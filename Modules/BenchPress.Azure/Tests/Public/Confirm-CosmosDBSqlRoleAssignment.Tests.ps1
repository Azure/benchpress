BeforeAll {
    . $PSScriptRoot/../../Public/Confirm-CosmosDBSqlRoleAssignment.ps1
    . $PSScriptRoot/../../Private/Connect-Account.ps1
    Import-Module Az
  }
  
  Describe "Confirm-CosmosDBSqlRoleAssignment" {
    Context "unit tests" -Tag "Unit" {
      BeforeEach {
        Mock Connect-Account{}
      }
  
      It "Calls Get-AzCosmosDBSqlRoleAssignment" {
        Mock Get-AzCosmosDBSqlRoleAssignment{}
        Confirm-CosmosDBSqlRoleAssignment -ResourceGroupName "rgn" -AccountName "cdba" -Name "cdbsqldb"
        Should -Invoke -CommandName "Get-AzCosmosDBSqlRoleAssignment" -Times 1
      }
    }
  }
  
  AfterAll {
    Remove-Module Az
  }
