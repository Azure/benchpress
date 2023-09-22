BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-SearchService.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az.Search
}

Describe "Confirm-SearchService" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzSearchService{}
    }

    It "Calls Get-AzSearchService" {
      Confirm-SearchService -Name "sn" -ResourceGroupName "rgn"
      Should -Invoke -CommandName "Get-AzSearchService" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az.Search
}
