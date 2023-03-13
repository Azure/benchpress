param location string = resourceGroup().location
param name string = 'str${take(uniqueString(resourceGroup().id), 6)}'

resource storage 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: name
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}
