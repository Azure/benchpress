param location string = resourceGroup().location
param name string = 'sample app service plan'

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: name
  location: location
  sku: {
    name: 'S1'
    tier: 'Free'
  }
  kind: 'app'
}
