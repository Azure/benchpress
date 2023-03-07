BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-OperationalInsightsWorkspace.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-OperationalInsightsWorkspace" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
    }

    It "Calls Get-AzApplicationInsights" {
      Mock Get-AzOperationalInsightsWorkspace{}
      Confirm-OperationalInsightsWorkspace -Name "loganalytics" -ResourceGroupName "rgn"
      Should -Invoke -CommandName "Get-AzOperationalInsightsWorkspace" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
