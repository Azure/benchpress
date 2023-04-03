BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:principalId = 'sampleappid'
  $Script:scope = '/subscriptions/id'
  $Script:roleName = 'Reader'
}

Describe 'Verify Role Assignment Exists' {
  BeforeAll {
    $Script:noRoleName = 'Owner'
  }

  It "Should have a Service Principal with $roleName Role - Confirm-AzBPResource" {
    #act
    $params = @{
      ResourceType         = 'RoleAssignment'
      ServicePrincipalId   = $principalId
      RoleDefinitionName   = $roleName
      Scope                = $scope
    }

    #assert
    (Confirm-AzBPRoleAssignment @params).Success | Should -Be $true
  }

  It "Should have a Service Principal with $roleName Role" {
    #act
    $params = @{
      ResourceType         = 'RoleAssignment'
      ServicePrincipalId   = $principalId
      RoleDefinitionName   = $roleName
      Scope                = $scope
    }

    #assert
    (Confirm-AzBPRoleAssignment @params).Success | Should -Be $true
  }

  It "Should not have a Service Principal with $noRoleName Role" {
    #act
    $params = @{
      ServicePrincipalId   = $principalId
      RoleDefinitionName   = $noRoleName
      Scope                = $scope
    }

    #assert
    (Confirm-AzBPRoleAssignment @params).Success | Should -Be $false
  }

}

AfterAll {
  Get-Module Az-InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
