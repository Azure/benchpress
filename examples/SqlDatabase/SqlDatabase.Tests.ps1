BeforeAll {
  Import-Module Az-InfrastructureTest
}

Describe 'Verify Sql Database Exists' {
    it 'Should contain a Sql Database with the given name' {
        #arrange
        $rgName = 'rg-test'
        $serverName = 'samplesqlserver'
        $databaseName = 'samplesqldatabase'

        #act
        $result =  Confirm-AzBPSqlDatabase -ResourceGroupName $rgName -DatabaseName $databaseName -ServerName $serverName

        #assert
        $result.Success | Should -Be $true
    }
}

Describe 'Verify Sql Database Does Not Exist' {
    it 'Should not contain a Sql Database with the given name' {
        #arrange
        $rgName = 'rg-test'
        $serverName = 'samplesqlserver'
        $databaseName = 'nosamplesqldatabase'

        #act
        # The '-ErrorAction SilentlyContinue' command suppresses all errors.
        # In this test, it will suppress the error message when a resource cannot be found.
        # Remove this field to see all errors.
        $result =  Confirm-AzBPSqlDatabase -ResourceGroupName $rgName -DatabaseName $databaseName -ServerName $serverName -ErrorAction SilentlyContinue

        #assert
        $result.Success | Should -Be $false
    }
}
