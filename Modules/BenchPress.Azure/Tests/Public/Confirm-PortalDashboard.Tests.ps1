BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-PortalDashboard.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-PortalDashboard" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzPortalDashboard{}
    }

    It "Calls Get-AzPortalDashboard" {
      Confirm-PortalDashboard -Name "dashboard" -ResourceGroupName "rgn"
      Should -Invoke -CommandName "Get-AzPortalDashboard" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
