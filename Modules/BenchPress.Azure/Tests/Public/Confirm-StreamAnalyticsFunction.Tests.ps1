BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-StreamAnalyticsFunction.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-StreamAnalyticsFunction" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzStreamAnalyticsFunction{}
    }

    It "Calls Get-AzStreamAnalyticsFunction" {
      Confirm-StreamAnalyticsFunction -ResourceGroupName "rgn" -JobName "saj" -Name "f"
      Should -Invoke -CommandName "Get-AzStreamAnalyticsFunction" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
