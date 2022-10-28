targetScope='subscription'

param resourceGroupName string
param location string
param storageName string

resource newRG 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: resourceGroupName
  location: location
}

module storageAcct 'storageAccount.bicep' = {
  name: 'storageModule'
  scope: newRG
  params: {
    location: location
    name: storageName
  }
}
