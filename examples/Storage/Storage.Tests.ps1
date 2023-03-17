BeforeAll {
  Import-Module Az.InfrastructureTesting
}

Describe 'Verify Storage Account' {
  it 'Should contain a Storage Account with the given name' {
    #arrange
    $rgName = 'rg-test'
    $name = 'azbenchpressstorage'

    #act
    $result = Confirm-AzBPStorageAccount -ResourceGroupName $rgName -Name $name

    #assert
    $result.Success | Should -Be $true
  }

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

  it 'Should contain a Storage Account named azbenchpressstorage' {
    #arrange
    $rgName = 'rg-test'
    $name = 'azbenchpressstorage'

    #act
    $result = Confirm-AzBPStorageAccount -ResourceGroupName $rgName -Name $name

    #assert
    $result | Should -BeDeployed
  }

  it 'Should contain a Storage Account named azbenchpressstorage in westus3' {
    #arrange
    $rgName = 'rg-test'
    $name = 'azbenchpressstorage'

    #act
    $result = Confirm-AzBPStorageAccount -ResourceGroupName $rgName -Name $name
    #assert
    $result | Should -BeInLocation 'westus3'
  }

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

Describe 'Verify Storage Container' {
  it 'Should contain a Storage Container with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = 'rg-test'
      AccountName       = 'azbenchpressstorage'
      Name              = 'azbenchpresscontainer'
    }

    #act
    $result = Confirm-AzBPStorageContainer @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should not contain a Storage Container with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = 'rg-test'
      AccountName       = 'azbenchpressstorage'
      Name              = 'noazbenchpresscontainer'
      ErrorAction       = 'SilentlyContinue'
    }

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPStorageContainer @params

    #assert
    $result.Success | Should -Be $false
  }

  it 'Should contain a Storage Container named azbenchpresscontainer' {
    #arrange
    $params = @{
      ResourceGroupName = 'rg-test'
      AccountName       = 'azbenchpressstorage'
      Name              = 'azbenchpresscontainer'
    }

    #act
    $result = Confirm-AzBPStorageContainer @params

    #assert
    $result | Should -BeDeployed
  }
}
