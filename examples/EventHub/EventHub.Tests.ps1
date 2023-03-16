BeforeAll {
  Import-Module Az-InfrastructureTest
}

Describe 'Verify EventHub' {
  it 'Should contain an eventhub with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = 'rg-test'
      NamespaceName     = 'samplenamespace'
      Name              = 'eventhubtest'
    }

    #act
    $result = Confirm-AzBPEventHub @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should not contain an eventhub with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = 'rg-test'
      NamespaceName     = 'samplenamespace'
      Name              = 'eventhubtest2'
    }

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPEventHub @params -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }

  it 'Should contain an EventHub named eventhubtest' {
    #arrange
    $params = @{
      ResourceGroupName = 'rg-test'
      NamespaceName     = 'samplenamespace'
      Name              = 'eventhubtest'
    }

    #act
    $result = Confirm-AzBPEventHub @params

    #assert
    $result | Should -BeDeployed
  }

  it 'Should contain an EventHub named eventhubtest in westus3' {
    #arrange
    $params = @{
      ResourceGroupName = 'rg-test'
      NamespaceName     = 'samplenamespace'
      Name              = 'eventhubtest'
    }

    #act
    $result = Confirm-AzBPEventHub @params

    #assert
    $result | Should -BeInLocation 'westus3'
  }

  it 'Should be in a resource group named rg-test' {
    #arrange
    $params = @{
      ResourceGroupName = 'rg-test'
      NamespaceName     = 'samplenamespace'
      Name              = 'eventhubtest'
    }

    #act
    $result = Confirm-AzBPEventHub @params

    #assert
    $result | Should -BeInResourceGroup 'rg-test'
  }
}

Describe 'Verify EventHub Namespace' {
  it 'Should contain an eventhub namespace with the given name' {
    #arrange
    $rgName = 'rg-test'
    $namespaceName = 'samplenamespace'

    #act
    $result = Confirm-AzBPEventHubNamespace -NamespaceName $namespaceName -ResourceGroupName $rgName

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should not contain an eventhub namespace with the given name' {
    #arrange
    $rgName = 'rg-test'
    $namespaceName = 'samplenamespace2'

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPEventHubNamespace -NamespaceName $namespaceName -ResourceGroupName $rgName

    #assert
    $result.Success | Should -Be $false
  }

  it 'Should contain an EventHub Namespace named samplenamespace' {
    #arrange
    $rgName = 'rg-test'
    $namespaceName = 'samplenamespace'

    #act
    $result = Confirm-AzBPEventHubNamespace -NamespaceName $namespaceName -ResourceGroupName $rgName

    #assert
    $result | Should -BeDeployed
  }

  it 'Should contain an EventHub Namespace named samplenamespace in westus3' {
    #arrange
    $rgName = 'rg-test'
    $namespaceName = 'samplenamespace'

    #act
    $result = Confirm-AzBPEventHubNamespace -NamespaceName $namespaceName -ResourceGroupName $rgName

    #assert
    $result | Should -BeInLocation 'westus3'
  }

  it 'Should be in a resource group named rg-test' {
    #arrange
    $rgName = 'rg-test'
    $namespaceName = 'samplenamespace'

    #act
    $result = Confirm-AzBPEventHubNamespace -NamespaceName $namespaceName -ResourceGroupName $rgName

    #assert
    $result | Should -BeInResourceGroup 'rg-test'
  }
}

Describe 'Verify EventHub Consumer Group' {
  it 'Should contain an eventhub consumer group with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = 'rg-test'
      NamespaceName     = 'samplenamespace'
      EventHubName      = 'eventhubtest'
      Name              = 'eventhubconsumergrouptest'
    }

    #act
    $result = Confirm-AzBPEventHubConsumerGroup @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should not contain an eventhub consumer group with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = 'rg-test'
      NamespaceName     = 'samplenamespace'
      EventHubName      = 'eventhubtest'
      Name              = 'eventhubconsumergrouptest2'
    }

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPEventHubConsumerGroup @params -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }

  it 'Should contain an EventHub consumer group named consumergrouptest' {
    #arrange
    $params = @{
      ResourceGroupName = 'rg-test'
      NamespaceName     = 'samplenamespace'
      EventHubName      = 'eventhubtest'
      Name              = 'eventhubconsumergrouptest'
    }

    #act
    $result = Confirm-AzBPEventHubConsumerGroup @params

    #assert
    $result | Should -BeDeployed
  }

  it 'Should contain an EventHub consumer group named consumergrouptest in westus3' {
    #arrange
    $params = @{
      ResourceGroupName = 'rg-test'
      NamespaceName     = 'samplenamespace'
      EventHubName      = 'eventhubtest'
      Name              = 'eventhubconsumergrouptest'
    }

    #act
    $result = Confirm-AzBPEventHubConsumerGroup @params

    #assert
    $result | Should -BeInLocation 'westus3'
  }

  it 'Should be in a resource group named rg-test' {
    #arrange
    $params = @{
      ResourceGroupName = 'rg-test'
      NamespaceName     = 'samplenamespace'
      EventHubName      = 'eventhubtest'
      Name              = 'eventhubconsumergrouptest'
    }

    #act
    $result = Confirm-AzBPEventHubConsumerGroup @params

    #assert
    $result | Should -BeInResourceGroup 'rg-test'
  }
}
