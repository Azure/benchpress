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
      Confirm-RoleAssignment -RoleDefinitionName "Reader" -ServicePrincipalId "spn" -Scope "/subscriptions/"
      Should -Invoke -CommandName "Get-AzRoleAssignment" -Times 1
    }

    It "Fails with incorrectly formatted scope" {
      {Confirm-RoleAssignment -RoleDefinitionName "Reader" -ServicePrincipalId "spn" -Scope "samplescope"} | Should -Throw
    }
  }
}

AfterAll {
  Remove-Module Az
}
