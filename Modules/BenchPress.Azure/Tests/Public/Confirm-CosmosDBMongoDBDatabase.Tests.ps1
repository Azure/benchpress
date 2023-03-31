BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-CosmosDBMongoDBDatabase.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-CosmosDBMongoDBDatabase" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzCosmosDBMongoDBDatabase{}
    }

    It "Calls Get-AzCosmosDBMongoDBDatabase" {
      Confirm-CosmosDBMongoDBDatabase -ResourceGroupName "rgn" -AccountName "cdba" -Name "cdbsqldb"
      Should -Invoke -CommandName "Get-AzCosmosDBMongoDBDatabase" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
