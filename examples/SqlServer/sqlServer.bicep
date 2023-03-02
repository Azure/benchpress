param location string = resourceGroup().location
param name string = 'sqlsvr${take(uniqueString(resourceGroup().id), 5)}'
@secure()
param adminPassword string

resource sqlServer 'Microsoft.Sql/servers@2022-05-01-preview' = {
  name: name
  location: location
  properties: {
    administratorLogin: 'administratorLogin'
    administratorLoginPassword: adminPassword
  }
}
