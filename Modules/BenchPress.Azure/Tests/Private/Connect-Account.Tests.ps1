﻿using module ./../../Classes/AuthenticationResult.psm1
using module ./../../Classes/AuthenticationData.psm1

BeforeAll {
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}


Describe "Connect-Account" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      $MockApplicationId = "AppId"
      $MockTenantId = "TenantId"
      $MockSubscriptionId = "SubId"
      $MockSubscriptionName = "SubName"
      $MockEncryptedPassword = "EncryptedPassword"

      Mock Get-EnvironmentVariable{ return $MockApplicationId } -ParameterFilter { $VariableName -eq "AZ_APPLICATION_ID" }
      Mock Get-EnvironmentVariable{ return $MockTenantId } -ParameterFilter { $VariableName -eq "AZ_TENANT_ID" }
      Mock Get-EnvironmentVariable{ return $MockSubscriptionId } -ParameterFilter { $VariableName -eq "AZ_SUBSCRIPTION_ID" }
      Mock Get-EnvironmentVariable{ return $MockEncryptedPassword } -ParameterFilter { $VariableName -eq "AZ_ENCRYPTED_PASSWORD" }

      Mock Get-AzSubscription { @{Name = $MockSubscriptionName } }  -ParameterFilter { $SubscriptionId -eq $MockSubscriptionId }
      Mock New-Object{ New-MockObject -Type "System.Management.Automation.PSCredential" } `
        -ParameterFilter { $TypeName -eq "System.Management.Automation.PSCredential" }

      Mock ConvertTo-SecureString{}
      Mock Connect-AzAccount{}
    }

    It "Does not Invokes Connect-AzAccount when a context exists" {
      # Arrange
      Mock Get-EnvironmentVariable{ return "true" } -ParameterFilter { $VariableName -eq "AZ_USE_MANAGED_IDENTITY" -and $DontThrowIfMissing -eq $true }
      Mock Set-AzContext {}

      Mock Get-AzContext { @{Account      = @{Type = "Mocked"; Id = $MockApplicationId};
      Tenant       = @{Id = $MockTenantId};
      Subscription = @{Id = $MockSubscriptionId}}}

      # Act
      Connect-Account

      # Assert Connect-AzAccount was not called and we are using the existing context
      Assert-MockCalled Connect-AzAccount -Exactly 0
    }

    It "Invokes Connect-AzAccount with -Identity when AZ_USE_MANAGED_IDENTITY is set." {
      # Arrange
      Mock Get-EnvironmentVariable{ return "true" } -ParameterFilter { $VariableName -eq "AZ_USE_MANAGED_IDENTITY" -and $DontThrowIfMissing -eq $true }
      Mock Set-AzContext {}

      Mock Get-AzContext { return $null} -Verifiable

      # Act
      Connect-Account

      # Assert
      Assert-MockCalled Connect-AzAccount -ParameterFilter {
        $Identity -eq $true `
        -and $ServicePrincipal -eq $null
      }

      Assert-MockCalled Get-AzSubscription  -ParameterFilter {
        $SubscriptionId -eq $MockSubscriptionId
      }

      Assert-MockCalled Set-AzContext -ParameterFilter {
        $Subscription -eq $MockSubscriptionName
      }
    }

    It "Invokes Connect-AzAccount with -ServicePrincipal when the context is empty and environment variables exist" {
      Mock Get-BooleanEnvironmentVariable{ return $False } -ParameterFilter { $VariableName -eq "AZ_USE_MANAGED_IDENTITY" }
      Mock Get-AzContext { return $null } -Verifiable
      Mock Set-AzContext {}

      Connect-Account

      Assert-MockCalled Connect-AzAccount -ParameterFilter {
        $ServicePrincipal -eq $true `
        -and $TenantId -eq $MockTenantId `
        -and $SubscriptionId -eq $MockSubscriptionId
      }
    }

    It "Does not invoke Connect-AzAccount when the account matches environment variables." {
      Mock Get-AzContext { @{Account      = @{Type = "ServicePrincipal"; Id = $MockApplicationId};
                             Tenant       = @{Id = $MockTenantId};
                             Subscription = @{Id = $MockSubscriptionId}}}

      Connect-Account

      Should -Invoke  -CommandName "Connect-AzAccount" -Times 0
    }

    It "Invokes Connect-AzAccount when the application ID does not match environment variables." {
      Mock Get-AzContext { @{Account      = @{Type = "ServicePrincipal"; Id = "not application ID"};
                             Tenant       = @{Id = $TenantId};
                             Subscription = @{Id = $SubscriptionId}}} `
        -Verifiable

      Connect-Account

      Assert-MockCalled Connect-AzAccount
    }

    It "Invokes Connect-AzAccount when the tenant ID does not match environment variables." {
      Mock Get-AzContext { @{Account      = @{Type = "ServicePrincipal"; Id = $ApplicationId};
                             Tenant       = @{Id = "not tenant id"};
                             Subscription = @{Id = $SubscriptionId}}} `
        -Verifiable

      Connect-Account

      Assert-MockCalled Connect-AzAccount
    }

    It "Invokes Connect-AzAccount when the subscription ID does not match environment variables." {
      Mock Get-AzContext { @{Account      = @{Type = "ServicePrincipal"; Id = $ApplicationId};
                             Tenant       = @{Id = $TenantId};
                             Subscription = @{Id = "Not subscription id"}}} `
        -Verifiable

      Connect-Account

      Assert-MockCalled Connect-AzAccount
    }
  }
}

AfterAll {
  Remove-Module Az
}
