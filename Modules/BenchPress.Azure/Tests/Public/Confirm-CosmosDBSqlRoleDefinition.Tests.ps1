BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-CosmosDBSqlRoleDefinition.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-CosmosDBSqlRoleDefinition" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzCosmosDBSqlRoleDefinition{}
    }

    It "Calls Get-AzCosmosDBSqlRoleDefinition" {
      $params = @{
        ResourceGroupName = "rgn"
        AccountName = "cdba"
        RoleDefinitionId = "roledefinitionid"
      }
      Confirm-CosmosDBSqlRoleDefinition @params
      Should -Invoke -CommandName "Get-AzCosmosDBSqlRoleDefinition" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
