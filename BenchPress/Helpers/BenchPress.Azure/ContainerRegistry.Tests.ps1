BeforeAll {
  Import-Module $PSScriptRoot/ContainerRegistry.psm1
  Import-Module Az
}

Describe "Get-ContainerRegistry" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName ContainerRegistry Get-AzContainerRegistry{}
    }

    It "Calls Get-AzContainerRegistry" {
      Get-ContainerRegistry -Name "cr" -ResourceGroupName "rgn"
      Should -Invoke -ModuleName ContainerRegistry -CommandName "Get-AzContainerRegistry" -Times 1
    }
  }
}

Describe "Get-ContainerRegistryExist" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName ContainerRegistry Get-ContainerRegistry{}
    }

    It "Calls Get-ContainerRegistry" {
      Get-ContainerRegistryExist -Name "cr" -ResourceGroupName "rgn"
      Should -Invoke -ModuleName ContainerRegistry -CommandName "Get-ContainerRegistry" -Times 1
    }
  }
}

AfterAll {
  Remove-Module ContainerRegistry
}

