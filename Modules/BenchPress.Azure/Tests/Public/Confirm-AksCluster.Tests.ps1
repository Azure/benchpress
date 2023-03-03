BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-AksCluster.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-AksCluster" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
    }

    It "Calls Get-AzAksCluster" {
      Mock Get-AzAksCluster{}
      Confirm-AksCluster -AksName "acn" -ResourceGroupName "rgn"
      Should -Invoke  -CommandName "Get-AzAksCluster" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
