BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-ActionGroup.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-ActionGroup" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzActionGroup{}
    }

    It "Calls Get-AzActionGroup" {
      Confirm-ActionGroup -ActionGroupName "agn" -ResourceGroupName "rgn"
      Should -Invoke -CommandName "Get-AzActionGroup" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
