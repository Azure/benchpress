BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:nameSpaceName = 'eventhubnamespace'
  $Script:eventHubName = 'eventhub'
  $Script:location = 'westus3'
}

Describe 'Verify EventHub' {
  BeforeAll {
    $Script:noEventHub = 'noeventhub'
  }

  It 'Should contain an eventhub with the given name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType      = "EventHub"
      ResourceGroupName = $rgName
      ResourceName      = $eventHubName
      NamespaceName     = $nameSpaceName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It 'Should contain an eventhub with the expected property name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType      = "EventHub"
      ResourceGroupName = $rgName
      ResourceName      = $eventHubName
      NamespaceName     = $nameSpaceName
      PropertyKey       = 'Name'
      PropertyValue     = $eventHubName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an EventHub named $eventHubName" {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      NamespaceName     = $nameSpaceName
      Name              = $eventHubName
    }

    #act
    Confirm-AzBPEventHub @params | Should -BeSuccessful
  }

  It 'Should not contain an eventhub with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      NamespaceName     = $nameSpaceName
      Name              = $noEventHub
    }

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    Confirm-AzBPEventHub @params -ErrorAction SilentlyContinue | Should -Not -BeSuccessful
  }

  It "Should contain an EventHub named $eventHubName in $location" {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      NamespaceName     = $nameSpaceName
      Name              = $eventHubName
    }

    #act
    Confirm-AzBPEventHub @params | Should -BeInLocation $location
  }

  It "Should be in a resource group named $rgName" {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      NamespaceName     = $nameSpaceName
      Name              = $eventHubName
    }

    #act
    Confirm-AzBPEventHub @params | Should -BeInResourceGroup $rgName
  }
}

Describe 'Verify EventHub Namespace' {
  BeforeAll {
    $Script:noNameSpaceName = 'nosamplenamespace'
  }

  It 'Should contain an eventhub namespace with the given name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType      = "EventHubNamespace"
      ResourceGroupName = $rgName
      ResourceName      = $nameSpaceName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It 'Should contain an eventhub namespace with the expected property name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType      = "EventHubNamespace"
      ResourceGroupName = $rgName
      ResourceName      = $nameSpaceName
      PropertyKey       = 'Name'
      PropertyValue     = $nameSpaceName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an EventHub Namespace named $nameSpaceName" {
    #act
    Confirm-AzBPEventHubNamespace -NamespaceName $namespaceName -ResourceGroupName $rgName | Should -BeSuccessful
  }

  It 'Should not contain an eventhub namespace with the given name' {
    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    Confirm-AzBPEventHubNamespace -NamespaceName $noNamespaceName -ResourceGroupName $rgName | Should -Not -BeSuccessful
  }

  It "Should contain an EventHub Namespace named $nameSpace in $location" {
    Confirm-AzBPEventHubNamespace -NamespaceName $namespaceName -ResourceGroupName $rgName | Should -BeInLocation $location
  }

  It "Should be in a resource group named $rgName" {
    Confirm-AzBPEventHubNamespace -NamespaceName $namespaceName -ResourceGroupName $rgName | Should -BeInResourceGroup $rgName
  }
}

Describe 'Verify EventHub Consumer Group' {
  BeforeAll {
    $Script:consumerGroupName = 'eventhubconsumergroup'
    $Script:noConsumerGroupName = 'noeventhubconsumergroup'
  }

  It 'Should contain an eventhub consumer group with the given name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType      = "EventHubConsumerGroup"
      ResourceGroupName = $rgName
      ResourceName      = $consumerGroupName
      NamespaceName     = $nameSpaceName
      EventHubName      = $eventHubName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It 'Should contain an eventhub consumer group with the expected property name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType      = "EventHubConsumerGroup"
      ResourceGroupName = $rgName
      ResourceName      = $consumerGroupName
      NamespaceName     = $nameSpaceName
      EventHubName      = $eventHubName
      PropertyKey       = 'Name'
      PropertyValue     = $consumerGroupName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an EventHub consumer group named $consumerGroupName" {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      NamespaceName     = $nameSpaceName
      EventHubName      = $eventHubName
      Name              = $consumerGroupName
    }

    #act
    Confirm-AzBPEventHubConsumerGroup @params | Should -BeSuccessful
  }

  It 'Should not contain an eventhub consumer group with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      NamespaceName     = $nameSpaceName
      EventHubName      = $eventHubName
      Name              = $noConsumerGroupName
    }

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    Confirm-AzBPEventHubConsumerGroup @params -ErrorAction SilentlyContinue | Should -Not -BeSuccessful
  }

  It "Should contain an EventHub consumer group named $consumerGroupName in $location" {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      NamespaceName     = $nameSpaceName
      EventHubName      = $eventHubName
      Name              = $consumerGroupName
    }

    #act
    Confirm-AzBPEventHubConsumerGroup @params | Should -BeInLocation $location
  }

  It "Should be in a resource group named $rgName" {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      NamespaceName     = $nameSpaceName
      EventHubName      = $eventHubName
      Name              = $consumerGroupName
    }

    #act
    Confirm-AzBPEventHubConsumerGroup @params | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
