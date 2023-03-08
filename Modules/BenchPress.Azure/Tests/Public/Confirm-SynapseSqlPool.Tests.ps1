BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-SynapseSqlPool.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-SynapseSqlPool" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
    }

    It "Calls Get-AzSynapseSqlPool" {
      Mock Get-AzSynapseSqlPool{}
      Confirm-SynapseSqlPool -SynapseSqlPoolName "sql" -WorkspaceName "syn" -ResourceGroupName "rgn"
      Should -Invoke -CommandName "Get-AzSynapseSqlPool" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
