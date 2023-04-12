targetScope = 'subscription'

param name string = 'rg${take(uniqueString(subscription().id), 5)}'
param location string = deployment().location

// https://docs.microsoft.com/en-us/azure/templates/microsoft.resources/resourcegroups?tabs=bicep
resource resourceGroup 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: name
  location: location
}

output name string = resourceGroup.name
output id string = resourceGroup.id
