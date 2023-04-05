param location string = resourceGroup().location
param name string = 'asp${take(uniqueString(resourceGroup().id), 5)}'

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: name
  location: location
  sku: {
    name: 'F1'
    tier: 'Free'
  }
  kind: 'app'
}
