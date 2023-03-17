param name string = 'evnthb${take(uniqueString(resourceGroup().id), 5)}'
param eventHubNamespaceName string = 'evnthbnmspace${take(uniqueString(resourceGroup().id), 5)}'
param consumerGroupName string = 'evntconsumer${take(uniqueString(resourceGroup().id), 5)}'
param location string = resourceGroup().location

var eventHubSku = 'Standard'

resource eventHubNamespace 'Microsoft.EventHub/namespaces@2021-11-01' = {
  name: eventHubNamespaceName
  location: location
  sku: {
    name: eventHubSku
    tier: eventHubSku
    capacity: 1
  }
  properties: {
    isAutoInflateEnabled: false
    maximumThroughputUnits: 0
  }
}

resource eventHub 'Microsoft.EventHub/namespaces/eventhubs@2021-11-01' = {
  parent: eventHubNamespace
  name: name
  properties: {
    messageRetentionInDays: 7
    partitionCount: 1
  }
}

resource eventHubConsumerGroup 'Microsoft.EventHub/namespaces/eventhubs/consumergroups@2021-11-01' = {
  name: consumerGroupName
  parent: eventHub
}
