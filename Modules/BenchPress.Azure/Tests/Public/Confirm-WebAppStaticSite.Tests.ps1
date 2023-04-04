BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-WebAppStaticSite.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-WebAppStaticSite" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzStaticWebApp{}
    }

    It "Calls Get-AzStaticWebApp" {
      Confirm-WebAppStaticSite -StaticWebAppName "swan" -ResourceGroupName "rgn"
      Should -Invoke -CommandName "Get-AzStaticWebApp" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
