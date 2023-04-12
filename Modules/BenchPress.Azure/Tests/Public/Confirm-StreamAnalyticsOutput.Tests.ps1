BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-StreamAnalyticsOutput.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-StreamAnalyticsOutput" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzStreamAnalyticsOutput{}
    }

    It "Calls Get-AzStreamAnalyticsOutput" {
      Confirm-StreamAnalyticsOutput -ResourceGroupName "rgn" -JobName "saj" -Name "o"
      Should -Invoke -CommandName "Get-AzStreamAnalyticsOutput" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
