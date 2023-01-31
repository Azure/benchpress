param location string = resourceGroup().location
param serverName string = 'azbpsqlserverwithdatabasetest1'
param databaseName string = 'samplesqldatabase'

resource sqlServer 'Microsoft.Sql/servers@2022-05-01-preview' = {
  name: serverName
  location: location
  properties: {
    administratorLogin: 'administratorLogin'
    administratorLoginPassword: '<sample-password>'
  }
}

resource sqlDB 'Microsoft.Sql/servers/databases@2022-05-01-preview' = {
  parent: sqlServer
  name: databaseName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
}
