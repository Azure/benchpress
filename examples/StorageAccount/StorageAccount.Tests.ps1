BeforeAll {
  Import-Module Az-InfrastructureTest
}

Describe 'Verify Storage Account Exists' {
    it 'Should contain a Storage Account with the given name' {
        #arrange
        $rgName = 'rg-test'
        $serverName = 'azbenchpressstorage'

        #act
        $result = Confirm-AzBPStorageAccount -ResourceGroupName $rgName -Name $serverName

        #assert
        $result.Success | Should -Be $true
    }
}

Describe 'Verify Storage Account Does Not Exist' {
    it 'Should not contain a Storage Account with the given name' {
        #arrange
        $rgName = 'rg-test'
        $serverName = 'noazbenchpressstorage'

        #act
        # The '-ErrorAction SilentlyContinue' command suppresses all errors.
        # In this test, it will suppress the error message when a resource cannot be found.
        # Remove this field to see all errors.
        $result = Confirm-AzBPStorageAccount -ResourceGroupName $rgName -Name $serverName -ErrorAction SilentlyContinue

        #assert
        $result.Success | Should -Be $false
    }
}
