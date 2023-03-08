BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-AppInsights.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-AppInsights" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
    }

    It "Calls Get-AzApplicationInsights" {
      Mock Get-AzApplicationInsights{}
      Confirm-AppInsights -Name "appinsights" -ResourceGroupName "rgn"
      Should -Invoke -CommandName "Get-AzApplicationInsights" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
