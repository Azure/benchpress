BeforeAll {
  Import-Module Az-InfrastructureTest
}

Describe 'Verify Web App Exists' {
    it 'Should contain a Web App with the given name' {
        #arrange
        $rgName = 'rg-test'
        $webappName = 'azbpwebapptest'

        #act
        $result = Confirm-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webappName

        #assert
        $result.Success | Should -Be $true
    }
}

Describe 'Verify Web App Does Not Exist' {
    it 'Should not contain a Web App with the given name' {
        #arrange
        $rgName = 'rg-test'
        $webappName = 'noazbpwebapptest'

        #act
        # The '-ErrorAction SilentlyContinue' command suppresses all errors.
        # In this test, it will suppress the error message when a resource cannot be found.
        # Remove this field to see all errors.
        $result = Confirm-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webappName -ErrorAction SilentlyContinue

        #assert
        $result.Success | Should -Be $false
    }
}
