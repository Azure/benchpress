BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-StreamAnalyticsJob.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-StreamAnalyticsJob" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzStreamAnalyticsJob{}
    }

    It "Calls Get-AzStreamAnalyticsJob" {
      Confirm-StreamAnalyticsJob -Name "saj" -ResourceGroupName "rgn"
      Should -Invoke -CommandName "Get-AzStreamAnalyticsJob" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
