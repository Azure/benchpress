BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-RoleAssignment.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-RoleAssignment" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
    }

    It "Calls Get-AzRoleAssignment" {
      Mock Get-AzRoleAssignment{}
      Confirm-RoleAssignment -RoleDefinitionName "Reader" -ServicePrincipalName "spn" -Scope "scope"
      Should -Invoke -CommandName "Get-AzRoleAssignment" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
