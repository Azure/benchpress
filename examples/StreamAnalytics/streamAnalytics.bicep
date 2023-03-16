param location string = resourceGroup().location
param name string = 'clstr${take(uniqueString(resourceGroup().id), 6)}'

resource symbolicname 'Microsoft.StreamAnalytics/clusters@2020-03-01' = {
  name: name
  location: location
  sku: {
    capacity: 36
    name: 'Default'
  }
}
