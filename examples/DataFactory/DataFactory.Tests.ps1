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

  It 'Should contain a data factory with the given name - Confirm-AzBPResource'{
    #arrange
    $params = @{
      ResourceType      = "DataFactory"
      ResourceGroupName = $rgName
      ResourceName      = $dataFactoryName
    }

    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a data factory named $dataFactoryName - Confirm-AzBPResource"{
    #arrange
    $params = @{
      ResourceType      = "DataFactory"
      ResourceGroupName = $rgName
      ResourceName      = $dataFactoryName
      PropertyKey       = 'DataFactoryName'
      PropertyValue     = $dataFactoryName
    }
    
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a data factory named $dataFactoryName" {
    Confirm-AzBPDataFactory -ResourceGroupName $rgName -Name $dataFactoryName | Should -BeSuccessful
  }

  It "Should not contain a data factory named $noDataFactoryName" {
    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    Confirm-AzBPDataFactory -ResourceGroupName $rgName -Name $noDataFactoryName -ErrorAction SilentlyContinue | Should -Not -BeSuccessful
  }

  It "Should contain a data factory named $dataFactoryName in $location" {
    Confirm-AzBPDataFactory -ResourceGroupName $rgName -Name $dataFactoryName | Should -BeInLocation $location
  }

  It "Should contain a data factory named $dataFactoryName deployed to $rgName resource group" {
    Confirm-AzBPDataFactory -ResourceGroupName $rgName -Name $dataFactoryName | Should -BeInResourceGroup $rgName
  }
}

Describe 'Verify Data Factory Linked Service' {
  BeforeAll {
    $Script:linkedServiceName = 'BenchpressStorageLinkedService'
  }

  It 'Should contain a data factory with a linked service - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType      = 'DataFactoryLinkedService'
      ResourceGroupName = $rgName
      DataFactoryName   = $dataFactoryName
      ResourceName      = $linkedServiceName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It 'Should contain a data factory with a linked service - Confirm-AzBPResource' {
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
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a data factory with a linked service named $linkedServiceName" {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      DataFactoryName   = $dataFactoryName
      Name              = $linkedServiceName
    }

    #act
    Confirm-AzBPDataFactoryLinkedService @params | Should -BeSuccessful
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
