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

  It "Should have a principal with $roleName role - Confirm-AzBPResource" {
    #act
    $params = @{
      ResourceType         = 'RoleAssignment'
      ServicePrincipalId   = $principalId
      RoleDefinitionName   = $roleName
      Scope                = $scope
    }

    #assert
    (Confirm-AzBPResource @params).Success | Should -Be $true
  }

  It "Should have a principal with $roleName role" {
    #act
    $params = @{
      ResourceType         = 'RoleAssignment'
      ServicePrincipalId   = $principalId
      RoleDefinitionName   = $roleName
      Scope                = $scope
    }

    #assert
    (Confirm-AzBPResource @params).Success | Should -Be $true
  }

  It "Should have a principal with $roleName role deployed" {
    #act
    $params = @{
      ServicePrincipalId   = $principalId
      RoleDefinitionName   = $roleName
      Scope                = $scope
    }

    Confirm-AzBPRoleAssignment @params | Should -BeDeployed
  }

  It "Should not have a principal with $noRoleName role" {
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
