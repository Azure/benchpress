using module ./public/classes/AuthenticationResult.psm1
using module ./public/classes/AuthenticationData.psm1

BeforeAll {
  Import-Module $PSScriptRoot/Authentication.psm1
  Import-Module Az
}

Describe "Connect-Account" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      $ApplicationId = "AppId"
      $TenantId = "TenantId"
      $SubscriptionId = "SubId"
      $EncryptedPassword = "EncryptedPassword"

      Mock Get-RequiredEnvironmentVariable{ return $ApplicationId } `
        -ParameterFilter { $VariableName -eq "AZ_APPLICATION_ID" } `
        -ModuleName Authentication
      Mock Get-RequiredEnvironmentVariable{ return $TenantId } `
        -ParameterFilter { $VariableName -eq "AZ_TENANT_ID" } `
        -ModuleName Authentication
      Mock Get-RequiredEnvironmentVariable{ return $SubscriptionId } `
        -ParameterFilter { $VariableName -eq "AZ_SUBSCRIPTION_ID" } `
        -ModuleName Authentication
      Mock Get-RequiredEnvironmentVariable{ return $EncryptedPassword } `
        -ParameterFilter { $VariableName -eq "AZ_ENCRYPTED_PASSWORD" } `
        -ModuleName Authentication
      Mock New-Object{ New-MockObject -Type "System.Management.Automation.PSCredential" } `
        -ModuleName Authentication `
        -ParameterFilter { $TypeName -eq "System.Management.Automation.PSCredential" }
      Mock ConvertTo-SecureString{} -ModuleName Authentication
      Mock Connect-AzAccount{} -ModuleName Authentication
    }

    It "Does not invoke Connect-AzAccount when the account matches environment variables." {
      Mock Get-AzContext { @{Account = @{Type = "ServicePrincipal"; Id = $ApplicationId};
                             Tenant = @{Id = $TenantId};
                             Subscription = @{Id = $SubscriptionId}}} `
        -ModuleName Authentication

      Connect-Account

      Should -Invoke -ModuleName Authentication -CommandName "Connect-AzAccount" -Times 0
    }

    It "Invokes Connect-AzAccount when the account type is not ServicePrincipal." {
      Mock Get-AzContext { @{Account = @{Type = "User"; Id = $ApplicationId};
                             Tenant = @{Id = $TenantId};
                             Subscription = @{Id = $SubscriptionId}}} `
        -ModuleName Authentication `
        -Verifiable

      Connect-Account

      Should -InvokeVerifiable
    }

    It "Invokes Connect-AzAccount when the application ID does not match environment variables." {
      Mock Get-AzContext { @{Account = @{Type = "ServicePrincipal"; Id = "not application ID"};
                             Tenant = @{Id = $TenantId};
                             Subscription = @{Id = $SubscriptionId}}} `
        -ModuleName Authentication `
        -Verifiable

      Connect-Account

      Should -InvokeVerifiable
    }

    It "Invokes Connect-AzAccount when the tenant ID does not match environment variables." {
      Mock Get-AzContext { @{Account = @{Type = "ServicePrincipal"; Id = $ApplicationId};
                             Tenant = @{Id = "not tenant id"};
                             Subscription = @{Id = $SubscriptionId}}} `
        -ModuleName Authentication `
        -Verifiable

      Connect-Account

      Should -InvokeVerifiable
    }

    It "Invokes Connect-AzAccount when the subscription ID does not match environment variables." {
      Mock Get-AzContext { @{Account = @{Type = "ServicePrincipal"; Id = $ApplicationId};
                             Tenant = @{Id = $TenantId};
                             Subscription = @{Id = "Not subscription id"}}} `
        -ModuleName Authentication `
        -Verifiable

      Connect-Account

      Should -InvokeVerifiable
    }

  }
}

AfterAll {
  Remove-Module Authentication
  Remove-Module Az
}
