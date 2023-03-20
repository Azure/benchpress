BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-StreamAnalyticsInput.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-StreamAnalyticsInput" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzStreamAnalyticsInput{}
    }

    It "Calls Get-AzStreamAnalyticsInput" {
      Confirm-StreamAnalyticsInput -ResourceGroupName "rgn" -JobName "saj" -Name "i"
      Should -Invoke -CommandName "Get-AzStreamAnalyticsInput" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
