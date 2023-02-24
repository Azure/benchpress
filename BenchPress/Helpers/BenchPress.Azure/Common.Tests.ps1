using module ./Common.psm1
using module ./public/classes/ConfirmResult.psm1

BeforeAll {
  Import-Module $PSScriptRoot/AppServicePlan.psm1
  Import-Module $PSScriptRoot/Authentication.psm1
  Import-Module $PSScriptRoot/Common.psm1
  Import-Module $PSScriptRoot/ResourceGroup.psm1
  Import-Module $PSScriptRoot/SqlDatabase.psm1
  Import-Module $PSScriptRoot/SqlServer.psm1
  Import-Module $PSScriptRoot/VirtualMachine.psm1
  Import-Module $PSScriptRoot/WebApp.psm1
}

Describe "Get-ResourceByType" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName Common Confirm-ResourceGroup{}
      Mock -ModuleName Common Confirm-AppServicePlan{}
      Mock -ModuleName Common Confirm-SqlDatabase{}
      Mock -ModuleName Common Confirm-SqlServer{}
      Mock -ModuleName Common Confirm-VirtualMachine{}
      Mock -ModuleName Common Confirm-WebApp{}
    }

    It "Calls <expected> when [ResourceType]::<resourceType> is used" -TestCases @(
      @{ ResourceType = [ResourceType]::ResourceGroup; Expected = "Confirm-ResourceGroup"}
      @{ ResourceType = [ResourceType]::AppServicePlan; Expected = "Confirm-AppServicePlan"}
      @{ ResourceType = [ResourceType]::SqlDatabase; Expected = "Confirm-SqlDatabase"}
      @{ ResourceType = [ResourceType]::SqlServer; Expected = "Confirm-SqlServer"}
      @{ ResourceType = [ResourceType]::VirtualMachine; Expected = "Confirm-VirtualMachine"}
      @{ ResourceType = [ResourceType]::WebApp; Expected = "Confirm-WebApp"}
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
      Mock -ModuleName Common Format-ErrorRecord{}
      Mock -ModuleName Common Format-IncorrectValueError{}
      Mock -ModuleName Common Format-PropertyDoesNotExistError{}
      $script:ConfirmResult = [ConfirmResult]::new(
        @{
          TestKey = "TestValue"
          TestArray = @(@{AnotherKey = "AnotherValue"})
        }, $null)
    }

    It "Calls Get-ResourceByType; returns true when Get-ResourceByType returns a Success ConfirmResult." {
      Mock -ModuleName Common Get-ResourceByType{ $ConfirmResult } -Verifiable

      $result = Confirm-Resource -ResourceType "ResourceGroup" -ResourceName "mockResourceName"

      Should -InvokeVerifiable
      Should -Invoke -ModuleName Common -CommandName "Format-NotExistError" -Times 0
      Should -Invoke -ModuleName Common -CommandName "Format-IncorrectValueError" -Times 0
      $result.Success | Should -Be $true
    }

    It "Calls Get-ResourceByType; returns true when property matches value." {
      Mock -ModuleName Common Get-ResourceByType{ $ConfirmResult } -Verifiable

      $result = Confirm-Resource -ResourceType "ResourceGroup" -ResourceName "mockResourceName" `
        -PropertyKey "TestKey" -PropertyValue "TestValue"

      Should -InvokeVerifiable
      Should -Invoke -ModuleName Common -CommandName "Format-NotExistError" -Times 0
      Should -Invoke -ModuleName Common -CommandName "Format-IncorrectValueError" -Times 0

      $result.Success | Should -Be $true
    }

    It "Calls Get-ResourceByType; returns true when accessing property in array and matches value." {
      Mock -ModuleName Common Get-ResourceByType{ $ConfirmResult } -Verifiable

      $result = Confirm-Resource -ResourceType "ResourceGroup" -ResourceName "mockResourceName" `
        -PropertyKey "TestArray[0].AnotherKey" -PropertyValue "AnotherValue"

      Should -InvokeVerifiable
      Should -Invoke -ModuleName Common -CommandName "Format-NotExistError" -Times 0
      Should -Invoke -ModuleName Common -CommandName "Format-IncorrectValueError" -Times 0

      $result.Success | Should -Be $true
    }

    It "Calls Get-ResourceByType and Format-Error; returns false when Get-ResourceByType returns empty object." {
      Mock -ModuleName Common Get-ResourceByType{ return $null } -Verifiable

      $result = Confirm-Resource -ResourceType "ResourceGroup" -ResourceName "mockResourceName"

      Should -InvokeVerifiable
      Should -Invoke -ModuleName Common -CommandName "Format-ErrorRecord" -Times 1
      Should -Invoke -ModuleName Common -CommandName "Format-IncorrectValueError" -Times 0
      $result.Success | Should -Be $false
    }

    It "Calls Get-ResourceByType and Format-IncorrectValueError; returns false when property does not match value." {
      Mock -ModuleName Common Get-ResourceByType{ $ConfirmResult } -Verifiable

      $result = Confirm-Resource -ResourceType "ResourceGroup" -ResourceName "mockResourceName" `
        -PropertyKey "TestKey" -PropertyValue "WrongValue"

      Should -InvokeVerifiable
      Should -Invoke -ModuleName Common -CommandName "Format-NotExistError" -Times 0
      Should -Invoke -ModuleName Common -CommandName "Format-IncorrectValueError" -Times 1

      $result.Success | Should -Be $false
    }

    It "Calls Get-ResourceByType; returns false when indexing incorrectly into property array" {
      Mock -ModuleName Common Get-ResourceByType{ $ConfirmResult } -Verifiable

      $result = Confirm-Resource -ResourceType "ResourceGroup" -ResourceName "mockResourceName" `
        -PropertyKey "WrongArray[0].AnotherKey" -PropertyValue "AnotherValue"

      Should -InvokeVerifiable

      $result.Success | Should -Be $false
      $result.ErrorRecord | Should -Not -Be $null
    }

    It "Calls Get-ResourceByType and Format-PropertyDoesNotExistError; returns false when property does not exist." {
      Mock -ModuleName Common Get-ResourceByType{ $ConfirmResult } -Verifiable

      $result = Confirm-Resource -ResourceType "ResourceGroup" -ResourceName "mockResourceName" `
        -PropertyKey "WrongKey" -PropertyValue "TestValue"

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
      Mock -ModuleName Common New-Object{} -Verifiable
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
