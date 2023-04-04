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
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should have a Service Principal with $roleName Role - Confirm-AzBPResource" {
    #act
    $params = @{
      ResourceType         = 'RoleAssignment'
      ServicePrincipalId   = $principalId
      RoleDefinitionName   = $roleName
      Scope                = $scope
      PropertyKey          = 'RoleDefinitionName'
      PropertyValue        = $roleName
    }

    #assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should not have a Service Principal with $noRoleName Role" {
    #act
    $params = @{
      ServicePrincipalId   = $principalId
      RoleDefinitionName   = $noRoleName
      Scope                = $scope
    }

    #assert
    Confirm-AzBPRoleAssignment @params | Should -Not -BeSuccessful
  }

}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
