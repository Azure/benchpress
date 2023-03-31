BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-SynapseSparkPool.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-SynapseSparkPool" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzSynapseSparkPool{}
    }

    It "Calls Get-AzSynapseSparkPool" {
      Confirm-SynapseSparkPool -SynapseSparkPoolName "spark" -WorkspaceName "syn" -ResourceGroupName "rgn"
      Should -Invoke -CommandName "Get-AzSynapseSparkPool" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
