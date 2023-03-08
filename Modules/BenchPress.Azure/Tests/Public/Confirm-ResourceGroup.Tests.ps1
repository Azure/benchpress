BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-ResourceGroup.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-ResourceGroup" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
    }

    It "Calls Get-AzResourceGroup" {
      Mock Get-AzResourceGroup{}
      Confirm-ResourceGroup -ResourceGroupName "rgn"
      Should -Invoke -CommandName "Get-AzResourceGroup" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
