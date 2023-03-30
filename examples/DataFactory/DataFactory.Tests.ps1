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

  It "Should contain a Data Factory named $dataFactoryName - Confirm-AzBPResource" {
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

  It "Should contain a Data Factory named $dataFactoryName - Confirm-AzBPResource" {
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

  It "Should contain a Data Factory named $dataFactoryName" {
    #act
    $result = Confirm-AzBPDataFactory -ResourceGroupName $rgName -Name $dataFactoryName

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain a Data Factory named $dataFactoryName" {
    #act
    $result = Confirm-AzBPDataFactory -ResourceGroupName $rgName -Name $dataFactoryName

    #assert
    $result | Should -BeDeployed
  }

  It "Should contain a Data Factory named $dataFactoryName in $location" {
    #act
    $result = Confirm-AzBPDataFactory -ResourceGroupName $rgName -Name $dataFactoryName

    #assert
    $result | Should -BeInLocation $location
  }

  It "Should contain a Data Factory named $dataFactoryName in $rgName" {
    #act
    $result = Confirm-AzBPDataFactory -ResourceGroupName $rgName -Name $dataFactoryName

    #assert
    $result | Should -BeInResourceGroup $rgName
  }

  It "Should not contain a Data Factory named $noDataFactoryName" {
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

  It "Should contain a Data Factory with a Linked Service named $linkedServiceName - Confirm-AzBPResource" {
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

  It "Should contain a Data Factory with a Linked Service named $linkedServiceName - Confirm-AzBPResource" {
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

  It "Should contain a Data Factory with a Linked Service named $linkedServiceName" {
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

  It "Should contain a Data Factory with a Linked Service named $linkedServiceName" {
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

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
