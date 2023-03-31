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
      $params = @{
        ServicePrincipalId   = 'spn'
        RoleDefinitionName   = 'Reader'
        Scope                = '/subscriptions/'
      }
      Confirm-RoleAssignment @params
      Should -Invoke -CommandName "Get-AzRoleAssignment" -Times 1
    }

    It "Fails with incorrectly formatted scope" {
      $params = @{
        ServicePrincipalId   = 'spn'
        RoleDefinitionName   = 'Reader'
        Scope                = 'samplescope'
      }

      {Confirm-RoleAssignment @params -ErrorAction Stop} | Should -Throw
    }
  }
}

AfterAll {
  Remove-Module Az
}
