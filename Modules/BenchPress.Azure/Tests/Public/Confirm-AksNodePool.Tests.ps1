BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-AksNodePool.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-AksNodePool" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzAksNodePool{}
    }

    It "Calls Get-AzAksNodePool" {
      Confirm-AksNodePool -ResourceGroupName "rgn" -ClusterName "acn" -Name "anp"
      Should -Invoke  -CommandName "Get-AzAksNodePool" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
