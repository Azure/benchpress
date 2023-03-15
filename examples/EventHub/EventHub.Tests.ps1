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
}

Describe 'Verify EventHub Does Not Exist' {
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
}

Describe 'Verify EventHub Exists with Custom Assertion' {
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
}

Describe 'Verify EventHub Exists in Correct Location' {
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
}

Describe 'Verify EventHub Exists in Resource Group' {
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
}

Describe 'Verify EventHub Namespace Does Not Exist' {
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
}

Describe 'Verify EventHub Namespace Exists with Custom Assertion' {
  it 'Should contain an EventHub Namespace named samplenamespace' {
    #arrange
    $rgName = 'rg-test'
    $namespaceName = 'samplenamespace'

    #act
    $result = Confirm-AzBPEventHubNamespace -NamespaceName $namespaceName -ResourceGroupName $rgName

    #assert
    $result | Should -BeDeployed
  }
}

Describe 'Verify EventHub Namespace Exists in Correct Location' {
  it 'Should contain an EventHub Namespace named samplenamespace in westus3' {
    #arrange
    $rgName = 'rg-test'
    $namespaceName = 'samplenamespace'

    #act
    $result = Confirm-AzBPEventHubNamespace -NamespaceName $namespaceName -ResourceGroupName $rgName

    #assert
    $result | Should -BeInLocation 'westus3'
  }
}

Describe 'Verify EventHub Namespace Exists in Resource Group' {
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
}

Describe 'Verify EventHub Consumer Group Does Not Exist' {
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
}

Describe 'Verify EventHub Consumer Group Exists with Custom Assertion' {
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
}

Describe 'Verify EventHub Consumer Group Exists in Correct Location' {
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
}

Describe 'Verify EventHub Consumer Group Exists in Resource Group' {
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
