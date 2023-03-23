BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:dataFactoryName = 'sampleadf'
  $Script:location = 'westus3'
}

Describe 'Verify Data Factory' {
  BeforeAll {
    $Script:noDataFactoryName = 'nosampleadf'
  }

  it 'Should contain a data factory with the given name - Confirm-AzBPResource'{
    #arrange
    $params = @{
      ResourceType      = "DataFactory"
      ResourceGroupName = $rgName
      ResourceName      = $dataFactoryName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain a data factory named $dataFactoryName - Confirm-AzBPResource'{
    #arrange
    $params = @{
      ResourceType      = "DataFactory"
      ResourceGroupName = $rgName
      ResourceName      = $dataFactoryName
      PropertyKey       = 'DataFactoryName'
      PropertyValue     = $dataFactoryName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain a data factory named $dataFactoryName' {
    #act
    $result = Confirm-AzBPDataFactory -ResourceGroupName $rgName -Name $dataFactoryName

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain a data factory named $dataFactoryName' {
    #act
    $result = Confirm-AzBPDataFactory -ResourceGroupName $rgName -Name $dataFactoryName

    #assert
    $result | Should -BeDeployed
  }

  it 'Should contain a data factory named $dataFactoryName in $location' {
    #act
    $result = Confirm-AzBPDataFactory -ResourceGroupName $rgName -Name $dataFactoryName

    #assert
    $result | Should -BeInLocation $location
  }

  it 'Should contain a data factory named $dataFactoryName deployed to $rgName resource group' {
    #act
    $result = Confirm-AzBPDataFactory -ResourceGroupName $rgName -Name $dataFactoryName

    #assert
    $result | Should -BeInResourceGroup $rgName
  }

  it 'Should not contain a data factory named nosampleadf' {
    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPDataFactory -ResourceGroupName $rgName -Name $noDataFactoryName `
      -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }
}

Describe 'Verify Data Factory Linked Service' {
  BeforeAll {
    $Script:linkedServiceName = 'BenchpressStorageLinkedService'
  }

  it 'Should contain a data factory with a linked service - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType      = 'DataFactoryLinkedService'
      ResourceGroupName = $rgName
      DataFactoryName   = $dataFactoryName
      ResourceName      = $linkedServiceName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain a data factory with a linked service - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType      = 'DataFactoryLinkedService'
      ResourceGroupName = $rgName
      DataFactoryName   = $dataFactoryName
      ResourceName      = $linkedServiceName
      PropertyKey       = 'Name'
      PropertyValue     = $linkedServiceName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain a data factory with a linked service named BenchpressStorageLinkedService' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      DataFactoryName   = $dataFactoryName
      Name              = $linkedServiceName
    }

    #act
    $result = Confirm-AzBPDataFactoryLinkedService @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain a data factory with a linked service named BenchpressStorageLinkedService' {
    # Using custom assertion to check if the workspace with spark pool is deployed
    $params = @{
      ResourceGroupName = $rgName
      DataFactoryName   = $dataFactoryName
      Name              = $linkedServiceName
    }

    #act
    $result = Confirm-AzBPDataFactoryLinkedService @params

    #assert
    $result | Should -BeDeployed
  }
}
