using module ./Common.psm1

BeforeAll {
  Import-Module $PSScriptRoot/AppServicePlan.psm1
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
      Get-ResourceByType -ResourceName resource -ResourceGroupName group -ResourceType $ResourceType
      Should -Invoke -ModuleName Common -CommandName $Expected -Times 1
    }
  }
}

Describe "Get-Resource" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
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
      Mock -ModuleName Common New-NotExistError{}
      Mock -ModuleName Common New-IncorrectValueError{}
    }

    It "Calls Get-ResourceByType; returns true when Get-ResourceByType returns non empty object." {
      Mock -ModuleName Common Get-ResourceByType{ return "SomethingReturned" } -Verifiable

      $result = Confirm-Resource -ResourceType "ResourceGroup" -ResourceName "mockResourceName"

      Should -InvokeVerifiable
      Should -Invoke -ModuleName Common -CommandName "New-NotExistError" -Times 0
      Should -Invoke -ModuleName Common -CommandName "New-IncorrectValueError" -Times 0
      $result.Success | Should -Be $true
    }

    It "Calls Get-ResourceByType and New-NotExistError; returns false when Get-ResourceByType returns empty object." {
      Mock -ModuleName Common Get-ResourceByType{ return $null } -Verifiable

      $result = Confirm-Resource -ResourceType "ResourceGroup" -ResourceName "mockResourceName"

      Should -InvokeVerifiable
      Should -Invoke -ModuleName Common -CommandName "New-NotExistError" -Times 1
      Should -Invoke -ModuleName Common -CommandName "New-IncorrectValueError" -Times 0
      $result.Success | Should -Be $false
    }

    It "Calls Get-ResourceByType and New-IncorrectValueError; returns false when property does not match value." {
      Mock -ModuleName Common Get-ResourceByType{ return  @{TestKey = "WrongValue"} } -Verifiable

      $result = Confirm-Resource -ResourceType "ResourceGroup" -ResourceName "mockResourceName" `
        -PropertyKey "TestKey" -PropertyValue "RightValue"

      Should -InvokeVerifiable
      Should -Invoke -ModuleName Common -CommandName "New-NotExistError" -Times 0
      Should -Invoke -ModuleName Common -CommandName "New-IncorrectValueError" -Times 1

      $result.Success | Should -Be $false
    }
  }
}

Describe "ErrorRecord Helper Methods" {
  Context "unit tests" -Tag "Unit" {
    It "Calls New-ErrorRecord when New-NotExistError is called" {
      Mock -ModuleName Common New-ErrorRecord{} -Verifiable
      New-NotExistError -Message "testMessage"
      Should -InvokeVerifiable
    }

    It "Calls New-ErrorRecord when New-IncorrectValueError is called" {
      Mock -ModuleName Common New-ErrorRecord{} -Verifiable
      New-IncorrectValueError -Message "testMessage"
      Should -InvokeVerifiable
    }

    It "Creates ErrorRecord with correct message and ID when New-ErrorRecord is called" {
      Mock -ModuleName Common New-Object{} -Verifiable
      New-ErrorRecord -Message "testMessage" -ErrorID "testErrorID"
      Should -InvokeVerifiable
    }
  }
}

AfterAll {
  Remove-Module Common
  Remove-Module ResourceGroup
  Remove-Module AppServicePlan
  Remove-Module SqlDatabase
  Remove-Module SqlServer
  Remove-Module VirtualMachine
  Remove-Module WebApp
}
