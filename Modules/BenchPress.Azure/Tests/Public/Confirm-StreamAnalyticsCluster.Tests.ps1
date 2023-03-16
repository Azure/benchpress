BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-StreamAnalyticsCluster.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-StreamAnalyticsCluster" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
    }

    It "Calls Get-AzStreamAnalyticsCluster" {
      Mock Get-AzStreamAnalyticsCluster{}
      Confirm-StreamAnalyticsCluster -Name "sac" -ResourceGroupName "rgn"
      Should -Invoke -CommandName "Get-AzStreamAnalyticsCluster" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
