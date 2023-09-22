BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:principalId = 'sampleappid'
  $Script:scope = '/subscriptions/id'
  $Script:roleName = 'Reader'
  $Script:noRoleName = 'Owner'
}

Describe 'Verify Role Assignment Exists' {
  It "Should contain a Service Principal with $roleName Role - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType         = 'RoleAssignment'
      ServicePrincipalId   = $principalId
      RoleDefinitionName   = $roleName
      Scope                = $scope
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Service Principal with $roleName Role - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType         = 'RoleAssignment'
      ServicePrincipalId   = $principalId
      RoleDefinitionName   = $roleName
      Scope                = $scope
      PropertyKey          = 'RoleDefinitionName'
      PropertyValue        = $roleName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should not contain a Service Principal with $noRoleName Role" {
    # arrange
    $params = @{
      ServicePrincipalId   = $principalId
      RoleDefinitionName   = $noRoleName
      Scope                = $scope
    }

    # act and assert
    Confirm-AzBPRoleAssignment @params | Should -Not -BeSuccessful
  }

}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
