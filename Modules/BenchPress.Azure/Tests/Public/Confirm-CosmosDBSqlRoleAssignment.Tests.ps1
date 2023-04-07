BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-CosmosDBSqlRoleAssignment.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-CosmosDBSqlRoleAssignment" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzCosmosDBSqlRoleAssignment{}
    }

    It "Calls Get-AzCosmosDBSqlRoleAssignment" {
      $params = @{
        ResourceGroupName = "rgn"
        AccountName       = "cdba"
        RoleAssignmentId  = "roleassignmentid"
      }
      Confirm-CosmosDBSqlRoleAssignment @params
      Should -Invoke -CommandName "Get-AzCosmosDBSqlRoleAssignment" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
