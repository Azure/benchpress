BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-ContainerRegistry.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-ContainerRegistry" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzContainerRegistry{}
    }

    It "Calls Get-AzContainerRegistry" {
      Confirm-ContainerRegistry -Name "cr" -ResourceGroupName "rgn"
      Should -Invoke -CommandName "Get-AzContainerRegistry" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
