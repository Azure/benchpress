BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-CosmosDBSqlDatabase.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-CosmosDBSqlDatabase" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
    }

    It "Calls Get-AzCosmosDBSqlDatabase" {
      Mock Get-AzCosmosDBSqlDatabase{}
      Confirm-CosmosDBSqlDatabase -ResourceGroupName "rgn" -AccountName "cdba" -Name "cdbsqldb"
      Should -Invoke -CommandName "Get-AzCosmosDBSqlDatabase" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
