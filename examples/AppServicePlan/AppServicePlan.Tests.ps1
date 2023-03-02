BeforeAll {
  Import-Module Az-InfrastructureTest
}

Describe 'Verify App Service Plan Exists' {
    it 'Should contain an App Service Plan with the given name' {
        #arrange
        $rgName = 'rg-test'
        $appServicePlanName = 'appserviceplantest'

        #act
        $result = Confirm-AzBPAppServicePlan -ResourceGroupName $rgName -AppServicePlanName $appServicePlanName

        #assert
        $result.Success | Should -Be $true
    }
}

Describe 'Verify App Service Plan Does Not Exist' {
    it 'Should not contain an App Service Plan with the given name' {
        #arrange
        $rgName = 'rg-test'
        $appServicePlanName = 'noappserviceplantest'

        #act
        # The '-ErrorAction SilentlyContinue' command suppresses all errors.
        # In this test, it will suppress the error message when a resource cannot be found.
        # Remove this field to see all errors.
        $result = Confirm-AzBPAppServicePlan -ResourceGroupName $rgName -AppServicePlanName $appServicePlanName -ErrorAction SilentlyContinue

        #assert
        $result.Success | Should -Be $false
    }
}
