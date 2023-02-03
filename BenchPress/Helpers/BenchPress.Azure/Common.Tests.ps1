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

AfterAll {
  Remove-Module Common
  Remove-Module ResourceGroup
  Remove-Module AppServicePlan
  Remove-Module SqlDatabase
  Remove-Module SqlServer
  Remove-Module VirtualMachine
  Remove-Module WebApp
}


