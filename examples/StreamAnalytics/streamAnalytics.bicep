param location string = resourceGroup().location
param name string = 'clstr${take(uniqueString(resourceGroup().id), 6)}'

resource streamAnalyticsCluster 'Microsoft.StreamAnalytics/clusters@2020-03-01' = {
  name: name
  location: location
  sku: {
    capacity: 36
    name: 'Default'
  }
}

param streamAnalyticsJobName string = 'testjob'

resource streamingJob 'Microsoft.StreamAnalytics/streamingjobs@2020-03-01' = {
  name: streamAnalyticsJobName
  location: location
  properties: {
    sku: {
      name: 'Standard'
    }
    cluster: streamAnalyticsCluster
  }
}

param streamAnalyticsFunctionName string = 'testfunction'

resource function 'Microsoft.StreamAnalytics/streamingjobs/functions@2020-03-01' = {
  name: streamAnalyticsFunctionName
  parent: streamingJob
  properties: {
    properties: {
      binding: {
        type: 'Microsoft.StreamAnalytics/JavascriptUdf'
        properties: {
          script: 'return;'
        }
      }
    }
    type: 'Scalar'
  }
}

param streamAnalyticsInputName string = 'testinput'

resource symbolicname 'Microsoft.StreamAnalytics/streamingjobs/inputs@2020-03-01' = {
  name: streamAnalyticsInputName
  parent: streamingJob
  properties: {
    serialization: {
      type: 'Avro'
    }
    type: 'Stream'
    datasource: {
      type: 'Microsoft.Storage/Blob'
      properties: {
        container: 'container'
        pathPattern: '/'
        storageAccounts: [
          {
            accountKey: 'key'
            accountName: 'name'
          }
        ]
      }
    }
  }
}

param streamAnalyticsOutputName string = 'testoutput'

resource output 'Microsoft.StreamAnalytics/streamingjobs/outputs@2020-03-01' = {
  name: streamAnalyticsOutputName
  parent: streamingJob
  properties: {
    datasource: {
      type: 'Microsoft.Storage/Blob'
      properties: {
        container: 'container'
        pathPattern: '/'
        storageAccounts: [
          {
            accountKey: 'key'
            accountName: 'name'
          }
        ]
      }
    }
    serialization: {
      type: 'Avro'
    }
  }
}

param streamAnalyticsTransformationName string = 'testtransformation'
param numberOfStreamingUnits int = 1

resource transformation 'Microsoft.StreamAnalytics/streamingjobs/transformations@2020-03-01' = {
  name: streamAnalyticsTransformationName
  parent: streamingJob
  properties: {
    query: 'SELECT 1'
    streamingUnits: numberOfStreamingUnits
    validStreamingUnits: [
      1
    ]
  }
}
