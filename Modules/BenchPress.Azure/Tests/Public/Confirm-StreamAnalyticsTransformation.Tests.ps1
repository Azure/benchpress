BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-StreamAnalyticsTransformation.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-StreamAnalyticsTransformation" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzStreamAnalyticsTransformation{}
    }

    It "Calls Get-AzStreamAnalyticsTransformation" {
      Confirm-StreamAnalyticsTransformation -ResourceGroupName "rgn" -JobName "saj" -Name "f"
      Should -Invoke -CommandName "Get-AzStreamAnalyticsTransformation" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
