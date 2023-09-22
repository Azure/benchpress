BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:nameSpaceName = 'eventhubnamespace'
  $Script:eventHubName = 'eventhub'
  $Script:location = 'westus3'
}

Describe 'Verify Event Hub' {
  BeforeAll {
    $Script:noEventHub = 'noeventhub'
  }

  It "Should contain an Event Hub named $eventHubName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "EventHub"
      ResourceGroupName = $rgName
      ResourceName      = $eventHubName
      NamespaceName     = $nameSpaceName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an Event Hub named $eventHubName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "EventHub"
      ResourceGroupName = $rgName
      ResourceName      = $eventHubName
      NamespaceName     = $nameSpaceName
      PropertyKey       = 'Name'
      PropertyValue     = $eventHubName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an Event Hub named $eventHubName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      NamespaceName     = $nameSpaceName
      Name              = $eventHubName
    }

    # act and assert
    Confirm-AzBPEventHub @params | Should -BeSuccessful
  }

  It "Should contain an Event Hub named $eventHubName in $location" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      NamespaceName     = $nameSpaceName
      Name              = $eventHubName
    }

    # act and assert
    Confirm-AzBPEventHub @params | Should -BeInLocation $location
  }

  It "Should contain an Event Hub named $eventHubName in  $rgName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      NamespaceName     = $nameSpaceName
      Name              = $eventHubName
    }

    # act and assert
    Confirm-AzBPEventHub @params | Should -BeInResourceGroup $rgName
  }
}

Describe 'Verify Event Hub Namespace' {
  BeforeAll {
    $Script:noNameSpaceName = 'nosamplenamespace'
  }

  It "Should contain an Event Hub Namespace named $nameSpaceName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "EventHubNamespace"
      ResourceGroupName = $rgName
      ResourceName      = $nameSpaceName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an Event Hub Namespace named $nameSpaceName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "EventHubNamespace"
      ResourceGroupName = $rgName
      ResourceName      = $nameSpaceName
      PropertyKey       = 'Name'
      PropertyValue     = $nameSpaceName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an Event Hub Namespace named $nameSpaceName" {
    Confirm-AzBPEventHubNamespace -NamespaceName $namespaceName -ResourceGroupName $rgName | Should -BeSuccessful
  }

  It "Should contain an Event Hub Namespace named $nameSpaceName in $location" {
    Confirm-AzBPEventHubNamespace -NamespaceName $namespaceName -ResourceGroupName $rgName
    | Should -BeInLocation $location
  }

  It "Should contain an Event Hub Namespace named $nameSpaceName in $rgName" {
    Confirm-AzBPEventHubNamespace -NamespaceName $namespaceName -ResourceGroupName $rgName
    | Should -BeInResourceGroup $rgName
  }
}

Describe 'Verify Event Hub Consumer Group' {
  BeforeAll {
    $Script:consumerGroupName = 'eventhubconsumergroup'
    $Script:noConsumerGroupName = 'noeventhubconsumergroup'
  }

  It "Should contain an Event Hub Consumer Group named $consumerGroupName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "EventHubConsumerGroup"
      ResourceGroupName = $rgName
      ResourceName      = $consumerGroupName
      NamespaceName     = $nameSpaceName
      EventHubName      = $eventHubName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an Event Hub Consumer Group named $consumerGroupName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "EventHubConsumerGroup"
      ResourceGroupName = $rgName
      ResourceName      = $consumerGroupName
      NamespaceName     = $nameSpaceName
      EventHubName      = $eventHubName
      PropertyKey       = 'Name'
      PropertyValue     = $consumerGroupName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an Event Hub Consumer Group named $consumerGroupName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      NamespaceName     = $nameSpaceName
      EventHubName      = $eventHubName
      Name              = $consumerGroupName
    }

    # act and assert
    Confirm-AzBPEventHubConsumerGroup @params | Should -BeSuccessful
  }

  It "Should contain an Event Hub Consumer Group named $consumerGroupName in $location" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      NamespaceName     = $nameSpaceName
      EventHubName      = $eventHubName
      Name              = $consumerGroupName
    }

    # act and assert
    Confirm-AzBPEventHubConsumerGroup @params | Should -BeInLocation $location
  }

  It "Should contain an Event Hub Consumer Group named $consumerGroupName in $rgName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      NamespaceName     = $nameSpaceName
      EventHubName      = $eventHubName
      Name              = $consumerGroupName
    }

    # act and assert
    Confirm-AzBPEventHubConsumerGroup @params | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
