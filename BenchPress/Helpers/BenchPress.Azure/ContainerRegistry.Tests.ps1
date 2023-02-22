using module ./public/classes/ConfirmResult.psm1

BeforeAll {
  Import-Module $PSScriptRoot/Authentication.psm1
  Import-Module $PSScriptRoot/ContainerRegistry.psm1
  Import-Module Az
}

Describe "Confirm-ContainerRegistry" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName ContainerRegistry Connect-Account{}
    }

    It "Calls Get-AzContainerRegistry" {
      Mock -ModuleName ContainerRegistry Get-AzContainerRegistry{}
      Confirm-ContainerRegistry -Name "cr" -ResourceGroupName "rgn"
      Should -Invoke -ModuleName ContainerRegistry -CommandName "Get-AzContainerRegistry" -Times 1
    }

    It "Sets the ErrorRecord when an exception is thrown" {
      Mock -ModuleName ContainerRegistry Get-AzContainerRegistry{ throw [Exception]::new("Exception") }
      $Results = Confirm-ContainerRegistry -Name "cr" -ResourceGroupName "rgn"
      $Results.ErrorRecord | Should -Not -Be $null
    }
  }
}

AfterAll {
  Remove-Module Authentication
  Remove-Module ContainerRegistry
  Remove-Module Az
}
