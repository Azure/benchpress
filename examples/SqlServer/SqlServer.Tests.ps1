BeforeAll {
  Import-Module Az-InfrastructureTest
}

Describe 'Verify Sql Server Exists' {
    it 'Should contain a Sql Server with the given name' {
        #arrange
        $rgName = 'rg-test'
        $serverName = 'samplesqlserver'

        #act
        $result = Confirm-AzBPSqlServer -ResourceGroupName $rgName -ServerName $serverName

        #assert
        $result.Success | Should -Be $true
    }
}

Describe 'Verify Sql Server Does Not Exist' {
    it 'Should not contain a Sql Server with the given name' {
        #arrange
        $rgName = 'rg-test'
        $serverName = 'nosamplesqlserver'

        #act
        # The '-ErrorAction SilentlyContinue' command suppresses all errors.
        # In this test, it will suppress the error message when a resource cannot be found.
        # Remove this field to see all errors.
        $result = Confirm-AzBPSqlServer -ResourceGroupName $rgName -ServerName $serverName -ErrorAction SilentlyContinue

        #assert
        $result.Success | Should -Be $false
    }
}
