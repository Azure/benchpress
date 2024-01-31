Describe 'Verify Data Factory' {
  It "Should contain a Data Factory named $dataFactoryName - Confirm-AzBPResource" {
    $dataFactoryName = 'BenchpressDataFactory'
    # arrange
    $params = @{
      ResourceType      = "DataFactory"
      ResourceGroupName = $env:RESOURCE_GROUP_SUFFIX + "-rg"
      ResourceName      = $dataFactoryName
    }

    # act and assert
    Confirm-AzBPStorageAccount @params | Should -BeSuccessful
  }

  It "Should contain a Data Factory named $dataFactoryName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "DataFactory"
      ResourceGroupName = $rgName
      ResourceName      = $dataFactoryName
      PropertyKey       = 'DataFactoryName'
      PropertyValue     = $dataFactoryName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Data Factory named $dataFactoryName" {
    Confirm-AzBPDataFactory -ResourceGroupName $rgName -Name $dataFactoryName | Should -BeSuccessful
  }

  It "Should not contain a Data Factory named $noDataFactoryName" {
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    Confirm-AzBPDataFactory -ResourceGroupName $rgName -Name $noDataFactoryName -ErrorAction SilentlyContinue
    | Should -Not -BeSuccessful
  }

  It "Should contain a Data Factory named $dataFactoryName in $location" {
    Confirm-AzBPDataFactory -ResourceGroupName $rgName -Name $dataFactoryName | Should -BeInLocation $location
  }

  It "Should contain a Data Factory named $dataFactoryName in $rgName" {
    Confirm-AzBPDataFactory -ResourceGroupName $rgName -Name $dataFactoryName | Should -BeInResourceGroup $rgName
  }
}

Describe 'Verify Data Factory Linked Service' {
  BeforeAll {
    $Script:linkedServiceName = 'BenchpressStorageLinkedService'
  }

  It "Should contain a Data Factory with a Linked Service named $linkedServiceName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = 'DataFactoryLinkedService'
      ResourceGroupName = $rgName
      DataFactoryName   = $dataFactoryName
      ResourceName      = $linkedServiceName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Data Factory with a Linked Service named $linkedServiceName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = 'DataFactoryLinkedService'
      ResourceGroupName = $rgName
      DataFactoryName   = $dataFactoryName
      ResourceName      = $linkedServiceName
      PropertyKey       = 'Name'
      PropertyValue     = $linkedServiceName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Data Factory with a Linked Service named $linkedServiceName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      DataFactoryName   = $dataFactoryName
      Name              = $linkedServiceName
    }

    # act and assert
    Confirm-AzBPDataFactoryLinkedService @params | Should -BeSuccessful
  }
}
