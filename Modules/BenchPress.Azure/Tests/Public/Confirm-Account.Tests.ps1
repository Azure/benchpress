BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-ActionGroup.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-Account" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzContext{}
    }

    It "Calls Get-AzContext" {
      Confirm-Account
      Should -Invoke -CommandName "Get-AzContext" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
