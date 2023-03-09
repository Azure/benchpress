BeforeAll {
  Import-Module Az-InfrastructureTest
}

Describe 'Verify Data Factory' {
  it 'Should contain a data factory named sampleadf' {
    #arrange
    $rgName = 'rg-test'
    $dataFactoryName = 'sampleadf'

    #act
    $result = Confirm-AzBPDataFactory -ResourceGroupName $rgName -Name $dataFactoryName

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain a data factory named sampleadf' {
    # Using custom assertion to check if the data factory is deployed
    $rgName = 'rg-test'
    $dataFactoryName = 'sampleadf'

    #act
    $result = Confirm-AzBPDataFactory -ResourceGroupName $rgName -Name $dataFactoryName

    #assert
    $result | Should -BeDeployed
  }

  it 'Should contain a data factory named sampleadf in westus3' {
    # Using custom assertion to check if the workspace is in the correct location
    $rgName = 'rg-test'
    $dataFactoryName = 'sampleadf'
    $location = 'westus3'

    #act
    $result = Confirm-AzBPDataFactory -ResourceGroupName $rgName -Name $dataFactoryName

    #assert
    $result | Should -BeInLocation $location
  }

  it 'Should contain a data factory named sampleadf deployed to rg-test resource group' {
    # Using custom assertion to check if the workspace is in the correct location
    $rgName = 'rg-test'
    $dataFactoryName = 'sampleadf'

    #act
    $result = Confirm-AzBPDataFactory -ResourceGroupName $rgName -Name $dataFactoryName

    #assert
    $result | Should -BeInResourceGroup $rgName
  }

  it 'Should not contain a data factory named nosampleadf' {
    #arrange
    $rgName = 'rg-test'
    $dataFactoryName = 'nosampleadf'

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPDataFactory -ResourceGroupName $rgName -Name $dataFactoryName `
      -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }
}

Describe 'Verify Data Factory Linked Service' {
  it 'Should contain a data factory with a linked service named BenchpressStorageLinkedService' {
    #arrange
    $params = @{
      ResourceGroupName = 'rg-test'
      DataFactoryName   = 'sampleadf'
      Name              = 'BenchpressStorageLinkedService'
    }

    #act
    $result = Confirm-AzBPDataFactoryLinkedService @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain a data factory with a linked service named BenchpressStorageLinkedService' {
    # Using custom assertion to check if the workspace with spark pool is deployed
    $params = @{
      ResourceGroupName = 'rg-test'
      DataFactoryName   = 'sampleadf'
      Name              = 'BenchpressStorageLinkedService'
    }

    #act
    $result = Confirm-AzBPDataFactoryLinkedService @params

    #assert
    $result | Should -BeDeployed
  }

  it 'Should contain a data factory linked service located in west us 3' {
    # Using custom assertion to check if the spark pool is in the correct location
    $params = @{
      ResourceGroupName = 'rg-test'
      DataFactoryName   = 'sampleadf'
      Name              = 'BenchpressStorageLinkedService'
    }
    $location = 'westus3'

    #act
    $result = Confirm-AzBPDataFactoryLinkedService @params

    #assert
    $result | Should -BeInLocation $location
  }

  it 'Should contain a data factory linked service deployed to rg-test resource group' {
    # Using custom assertion to check if the workspace is in the correct location
    $rgName = 'rg-test'
    $dataFactoryName = 'sampleadf'

    #act
    $result = Confirm-AzBPDataFactory -ResourceGroupName $rgName -Name $dataFactoryName

    #assert
    $result | Should -BeInResourceGroup $rgName
  }
}
