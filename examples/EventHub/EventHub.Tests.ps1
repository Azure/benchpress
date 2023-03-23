BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:nameSpace = 'eventhubnamespace'
  $Script:eventHubName = 'eventhub'
  $Script:location = 'westus3'
}

Describe 'Verify EventHub' {
  BeforeAll {
    $Script:noEventHub = 'noeventhub'
  }

  it 'Should contain an eventhub with the given name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType      = "EventHub"
      ResourceGroupName = $rgName
      ResourceName      = $eventHubName
      NamespaceName     = $nameSpace
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain an eventhub with the expected property name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType      = "EventHub"
      ResourceGroupName = $rgName
      ResourceName      = $eventHubName
      NamespaceName     = $nameSpace
      PropertyKey       = 'Name'
      PropertyValue     = $eventHubName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
}

  it 'Should contain an eventhub with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      NamespaceName     = $nameSpace
      Name              = $eventHubName
    }

    #act
    $result = Confirm-AzBPEventHub @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should not contain an eventhub with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      NamespaceName     = $nameSpace
      Name              = $noEventHub
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
      ResourceGroupName = $rgName
      NamespaceName     = $nameSpace
      Name              = $eventHubName
    }

    #act
    $result = Confirm-AzBPEventHub @params

    #assert
    $result | Should -BeDeployed
  }

  it 'Should contain an EventHub named eventhubtest in westus3' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      NamespaceName     = $nameSpace
      Name              = $eventHubName
    }

    #act
    $result = Confirm-AzBPEventHub @params

    #assert
    $result | Should -BeInLocation $location
  }

  it 'Should be in a resource group named $rgName' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      NamespaceName     = $nameSpace
      Name              = $eventHubName
    }

    #act
    $result = Confirm-AzBPEventHub @params

    #assert
    $result | Should -BeInResourceGroup $rgName
  }
}

Describe 'Verify EventHub Namespace' {
  BeforeAll {
    $Script:noNameSpace = 'nosamplenamespace'
  }

  it 'Should contain an eventhub namespace with the given name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType      = "EventHubNamespace"
      ResourceGroupName = $rgName
      ResourceName      = $nameSpace
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain an eventhub namespace with the expected property name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType      = "EventHubNamespace"
      ResourceGroupName = $rgName
      ResourceName      = $nameSpace
      PropertyKey       = 'Name'
      PropertyValue     = $nameSpace
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain an eventhub namespace with the given name' {
    #arrange
    $rgName = $rgName
    $namespaceName = $nameSpace

    #act
    $result = Confirm-AzBPEventHubNamespace -NamespaceName $namespaceName -ResourceGroupName $rgName

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should not contain an eventhub namespace with the given name' {
    #arrange
    $rgName = $rgName
    $namespaceName = $noNameSpace

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
    $rgName = $rgName
    $namespaceName = $nameSpace

    #act
    $result = Confirm-AzBPEventHubNamespace -NamespaceName $namespaceName -ResourceGroupName $rgName

    #assert
    $result | Should -BeDeployed
  }

  it 'Should contain an EventHub Namespace named samplenamespace in westus3' {
    #arrange
    $rgName = $rgName
    $namespaceName = $nameSpace

    #act
    $result = Confirm-AzBPEventHubNamespace -NamespaceName $namespaceName -ResourceGroupName $rgName

    #assert
    $result | Should -BeInLocation $location
  }

  it 'Should be in a resource group named $rgName' {
    #arrange
    $rgName = $rgName
    $namespaceName = $nameSpace

    #act
    $result = Confirm-AzBPEventHubNamespace -NamespaceName $namespaceName -ResourceGroupName $rgName

    #assert
    $result | Should -BeInResourceGroup $rgName
  }
}

Describe 'Verify EventHub Consumer Group' {
  BeforeAll {
    $Script:consumerGroup = 'eventhubconsumergroup'
    $Script:noConsumerGroup = 'noeventhubconsumergroup'
  }

  it 'Should contain an eventhub consumer group with the given name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType      = "EventHubConsumerGroup"
      ResourceGroupName = $rgName
      ResourceName      = $consumerGroup
      NamespaceName     = $nameSpace
      EventHubName      = $eventHubName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain an eventhub consumer group with the expected property name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType      = "EventHubConsumerGroup"
      ResourceGroupName = $rgName
      ResourceName      = $consumerGroup
      NamespaceName     = $nameSpace
      EventHubName      = $eventHubName
      PropertyKey       = 'Name'
      PropertyValue     = $consumerGroup
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain an eventhub consumer group with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      NamespaceName     = $nameSpace
      EventHubName      = $eventHubName
      Name              = $consumerGroup
    }

    #act
    $result = Confirm-AzBPEventHubConsumerGroup @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should not contain an eventhub consumer group with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      NamespaceName     = $nameSpace
      EventHubName      = $eventHubName
      Name              = $noConsumerGroup
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
      ResourceGroupName = $rgName
      NamespaceName     = $nameSpace
      EventHubName      = $eventHubName
      Name              = $consumerGroup
    }

    #act
    $result = Confirm-AzBPEventHubConsumerGroup @params

    #assert
    $result | Should -BeDeployed
  }

  it 'Should contain an EventHub consumer group named consumergrouptest in westus3' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      NamespaceName     = $nameSpace
      EventHubName      = $eventHubName
      Name              = $consumerGroup
    }

    #act
    $result = Confirm-AzBPEventHubConsumerGroup @params

    #assert
    $result | Should -BeInLocation $location
  }

  it 'Should be in a resource group named $rgName' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      NamespaceName     = $nameSpace
      EventHubName      = $eventHubName
      Name              = $consumerGroup
    }

    #act
    $result = Confirm-AzBPEventHubConsumerGroup @params

    #assert
    $result | Should -BeInResourceGroup $rgName
  }
}
