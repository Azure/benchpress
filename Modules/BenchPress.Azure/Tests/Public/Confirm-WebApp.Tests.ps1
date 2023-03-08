BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-WebApp.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-WebApp" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
    }

    It "Calls Get-AzWebApp" {
      Mock Get-AzWebApp{}
      Confirm-WebApp -WebAppName "wan" -ResourceGroupName "rgn"
      Should -Invoke -CommandName "Get-AzWebApp" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
