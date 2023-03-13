BeforeAll {
  Import-Module Az-InfrastructureTest
}

Describe 'Verify Storage Account Exists' {
    it 'Should contain a Storage Account with the given name' {
        #arrange
        $rgName = 'rg-test'
        $name = 'azbenchpressstorage'

        #act
        $result = Confirm-AzBPStorageAccount -ResourceGroupName $rgName -Name $name

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

Describe 'Verify Storage Account Exists with Custom Assertion' {
  it 'Should contain a Storage Account named azbenchpressstorage' {
    #arrange
    $rgName = 'rg-test'
    $name = 'azbenchpressstorage'

    #act
    $result = Confirm-AzBPStorageAccount -ResourceGroupName $rgName -Name $name

    #assert
    $result | Should -BeDeployed
  }
}

Describe 'Verify Storage Account Exists in Correct Location' {
  it 'Should contain a Storage Account named azbenchpressstorage in westus3' {
    #arrange
    $rgName = 'rg-test'
    $name = 'azbenchpressstorage'

    #act
    $result = Confirm-AzBPStorageAccount -ResourceGroupName $rgName -Name $name
    #assert
    $result | Should -BeInLocation 'westus3'
  }
}

Describe 'Verify Storage Account Exists in Resource Group' {
  it 'Should be a Storage Account in a resource group named rg-test' {
    #arrange
    $rgName = 'rg-test'
    $name = 'azbenchpressstorage'

    #act
    $result = Confirm-AzBPStorageAccount -ResourceGroupName $rgName -Name $name

    #assert
    $result | Should -BeInResourceGroup 'rg-test'
  }
}
