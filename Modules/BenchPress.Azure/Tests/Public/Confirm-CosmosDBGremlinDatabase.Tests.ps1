BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-CosmosDBGremlinDatabase.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-CosmosDBGremlinDatabase" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzCosmosDBGremlinDatabase{}
    }

    It "Calls Get-AzCosmosDBGremlinDatabase" {
      Confirm-CosmosDBGremlinDatabase -ResourceGroupName "rgn" -AccountName "cdba" -Name "cdbsqldb"
      Should -Invoke -CommandName "Get-AzCosmosDBGremlinDatabase" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
