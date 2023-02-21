using module ./Common.psm1

BeforeAll {
  Import-Module $PSScriptRoot/AppServicePlan.psm1
  Import-Module $PSScriptRoot/Authentication.psm1
  Import-Module $PSScriptRoot/Common.psm1 -Force
  Import-Module $PSScriptRoot/ResourceGroup.psm1
  Import-Module $PSScriptRoot/SqlDatabase.psm1
  Import-Module $PSScriptRoot/SqlServer.psm1
  Import-Module $PSScriptRoot/VirtualMachine.psm1
  Import-Module $PSScriptRoot/WebApp.psm1
}

Describe "Get-ResourceByType" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName Common Get-ResourceGroup{}
      Mock -ModuleName Common Get-AppServicePlan{}
      Mock -ModuleName Common Get-SqlDatabase{}
      Mock -ModuleName Common Get-SqlServer{}
      Mock -ModuleName Common Get-VirtualMachine{}
      Mock -ModuleName Common Get-WebApp{}
    }

    It "Calls <expected> when [ResourceType]::<resourceType> is used" -TestCases @(
      @{ ResourceType = [ResourceType]::ResourceGroup; Expected = "Get-ResourceGroup"}
      @{ ResourceType = [ResourceType]::AppServicePlan; Expected = "Get-AppServicePlan"}
      @{ ResourceType = [ResourceType]::SqlDatabase; Expected = "Get-SqlDatabase"}
      @{ ResourceType = [ResourceType]::SqlServer; Expected = "Get-SqlServer"}
      @{ ResourceType = [ResourceType]::VirtualMachine; Expected = "Get-VirtualMachine"}
      @{ ResourceType = [ResourceType]::WebApp; Expected = "Get-WebApp"}
    ) {
      Get-ResourceByType -ResourceName resource -ResourceGroupName group -ResourceType $ResourceType -ServerName server
      Should -Invoke -ModuleName Common -CommandName $Expected -Times 1
    }
  }
}

Describe "Get-Resource" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName Common Connect-Account{}
      Mock -ModuleName Common Get-AzResource{}
    }

    It "Calls Get-AzResource without -ResourceGroupName parameter when not provided." {
      Get-Resource -ResourceName "rn"
      Should -Invoke -ModuleName Common -CommandName Get-AzResource -ParameterFilter { $name -eq "rn"; $resourceGroupName -eq $null }
    }

    It "Calls Get-AzResource with -ResourceGroupName parameter when provided." {
      Get-Resource -ResourceName "rn" -ResourceGroupName "rgn"
      Should -Invoke -ModuleName Common -CommandName Get-AzResource -ParameterFilter { $name -eq "rn"; $resourceGroupName -eq "rgn" }
    }
  }
}

Describe "Confirm-Resource" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName Common Format-NotExistError{}
      Mock -ModuleName Common Format-IncorrectValueError{}
      Mock -ModuleName Common Format-PropertyDoesNotExistError{}
    }

    It "Calls Get-ResourceByType; returns true when Get-ResourceByType returns non empty object." {
      Mock -ModuleName Common Get-ResourceByType{ return "SomethingReturned" } -Verifiable

      $result = Confirm-Resource -ResourceType "ResourceGroup" -ResourceName "mockResourceName"

      Should -InvokeVerifiable
      Should -Invoke -ModuleName Common -CommandName "Format-NotExistError" -Times 0
      Should -Invoke -ModuleName Common -CommandName "Format-IncorrectValueError" -Times 0
      $result.Success | Should -Be $true
    }

    It "Calls Get-ResourceByType and Format-NotExistError; returns false when Get-ResourceByType returns empty object." {
      Mock -ModuleName Common Get-ResourceByType{ return $null } -Verifiable

      $result = Confirm-Resource -ResourceType "ResourceGroup" -ResourceName "mockResourceName"

      Should -InvokeVerifiable
      Should -Invoke -ModuleName Common -CommandName "Format-NotExistError" -Times 1
      Should -Invoke -ModuleName Common -CommandName "Format-IncorrectValueError" -Times 0
      $result.Success | Should -Be $false
    }

    It "Calls Get-ResourceByType and Format-IncorrectValueError; returns false when property does not match value." {
      Mock -ModuleName Common Get-ResourceByType{ return  @{TestKey = "WrongValue"} } -Verifiable

      $result = Confirm-Resource -ResourceType "ResourceGroup" -ResourceName "mockResourceName" `
        -PropertyKey "TestKey" -PropertyValue "RightValue"

      Should -InvokeVerifiable
      Should -Invoke -ModuleName Common -CommandName "Format-NotExistError" -Times 0
      Should -Invoke -ModuleName Common -CommandName "Format-IncorrectValueError" -Times 1

      $result.Success | Should -Be $false
    }

    It "Calls Get-ResourceByType and Format-PropertyDoesNotExistError; returns false when property does not exist." {
      Mock -ModuleName Common Get-ResourceByType{ return  @{TestKey = "WrongValue"} } -Verifiable

      $result = Confirm-Resource -ResourceType "ResourceGroup" -ResourceName "mockResourceName" `
        -PropertyKey "WrongKey" -PropertyValue "RightValue"

      Should -InvokeVerifiable
      Should -Invoke -ModuleName Common -CommandName "Format-NotExistError" -Times 0
      Should -Invoke -ModuleName Common -CommandName "Format-PropertyDoesNotExistError" -Times 1

      $result.Success | Should -Be $false
    }
  }
}

Describe "ErrorRecord Helper Methods" {
  Context "unit tests" -Tag "Unit" {
    It "Calls Format-ErrorRecord when Format-NotExistError is called" {
      Mock -ModuleName Common Format-ErrorRecord{} -Verifiable
      Format-NotExistError -Message "testMessage"
      Should -InvokeVerifiable
    }

    It "Calls Format-ErrorRecord when Format-IncorrectValueError is called" {
      Mock -ModuleName Common Format-ErrorRecord{} -Verifiable
      Format-IncorrectValueError -Message "testMessage"
      Should -InvokeVerifiable
    }

    It "Calls Format-ErrorRecord when Format-PropertyDoesNotExistError is called" {
      Mock -ModuleName Common Format-ErrorRecord{} -Verifiable
      Format-PropertyDoesNotExistError -PropertyKey "testKey"
      Should -InvokeVerifiable
    }

    It "Creates ErrorRecord with correct message and ID when Format-ErrorRecord is called" {
      Mock -ModuleName Common Write-Error{} -Verifiable
      Format-ErrorRecord -Message "testMessage" -ErrorID "testErrorID"
      Should -InvokeVerifiable
    }
  }
}

AfterAll {
  Remove-Module Common
  Remove-Module ResourceGroup
  Remove-Module AppServicePlan
  Remove-Module Authentication
  Remove-Module SqlDatabase
  Remove-Module SqlServer
  Remove-Module VirtualMachine
  Remove-Module WebApp
}
