
param location string = resourceGroup().location
param appserviceplanName string = 'asp${take(uniqueString(resourceGroup().id), 5)}'
param webappName string = 'webapp${take(uniqueString(resourceGroup().id), 5)}'

resource appserviceplan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appserviceplanName
  location: location
  tags: {
    displayName: 'HostingPlan'
  }
  sku: {
    name: 'S1'
    capacity: 1
  }
}

resource website 'Microsoft.Web/sites@2022-03-01' = {
  name: webappName
  location: location
  tags: {
    'hidden-related:${appserviceplan.id}': 'empty'
    displayName: 'Website'
  }
  properties: {
    serverFarmId: appserviceplan.id
  }
}
