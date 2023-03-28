BeforeAll {
  Import-Module ../../bin/BenchPress.Azure.psd1

  $Script:principalId = 'sampleappid'
  $Script:scope = '/subscriptions/id'
  $Script:roleName = 'Reader'
}

Describe 'Verify Role Assignment Exists' {
  BeforeAll {
    $Script:noRoleName = 'Owner'
  }

  It "Should have a principal with $roleName role" {
    #act
    $params = @{
      ServicePrincipalId   = $principalId
      RoleDefinitionName   = $roleName
      Scope                = $scope
    }

    Confirm-RoleAssignment @params
    $result = Confirm-AzBPRoleAssignment @params
    #assert
    $result.Success | Should -Be $true
  }

  It "Should have a principal with $roleName role deployed" {
    #act
    $params = @{
      ServicePrincipalId   = $principalId
      RoleDefinitionName   = $roleName
      Scope                = $scope
    }
    Confirm-RoleAssignment @params
    $result = Confirm-AzBPRoleAssignment @params
    $result.Success | Should -BeDeployed
  }

  It "Should not have a principal with $noRoleName role" {
    #act
    $params = @{
      ServicePrincipalId   = $principalId
      RoleDefinitionName   = $noRoleName
      Scope                = $scope
    }
    Confirm-RoleAssignment @params
    $result = Confirm-AzBPRoleAssignment @params

    #assert
    $result.Success | Should -Be $false
  }

}

AfterAll {
  Get-Module Az-InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
