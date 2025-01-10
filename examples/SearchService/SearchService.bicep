param location string = resourceGroup().location
param name string = 'search${take(uniqueString(resourceGroup().id), 5)}'

resource search 'Microsoft.Search/searchServices@2023-11-01' = {
  name: name
  location: location
  properties: {
  }
}
