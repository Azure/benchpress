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
    $result = Confirm-AzBPRoleAssignment -ServicePrincipalId $principalId -RoleDefinitionName $roleName -Scope $scope
    #assert
    $result.Success | Should -Be $true
  }

  It "Should have a principal with $roleName role deployed" {
    #act
    $result = Confirm-AzBPRoleAssignment -ServicePrincipalId $principalId -RoleDefinitionName $roleName -Scope $scope
    #assert
    $result.Success | Should -BeDeployed
  }

  It "Should not have a principal with $noRoleName role" {
    #act
    $result = Confirm-AzBPRoleAssignment -ServicePrincipalId $principalId -RoleDefinitionName $noRoleName -Scope $scope

    #assert
    $result.Success | Should -Be $false
  }

}

AfterAll {
  Get-Module Az-InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
