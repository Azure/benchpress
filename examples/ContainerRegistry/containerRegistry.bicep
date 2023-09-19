param name string = 'acr${take(uniqueString(resourceGroup().id), 5)}'
param location string = resourceGroup().location

resource acr 'Microsoft.ContainerRegistry/registries@2023-08-01-preview' = {
  name: name
  location: location
  sku: {
    name: 'Basic'
  }
}
