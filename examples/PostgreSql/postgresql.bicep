param uaminame string = 'uami${take(uniqueString(subscription().id), 5)}'
param location string = resourceGroup().location
@secure()
param adminPassword string

resource uami 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: uaminame
  location: location
}

param name string = 'psql${take(uniqueString(subscription().id), 5)}'

resource symbolicname 'Microsoft.DBforPostgreSQL/flexibleServers@2022-12-01' = {
  name: name
  location: location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${uami.id}': {}
    }
  }
  properties: {
    administratorLogin: 'administratorLogin'
    administratorLoginPassword: adminPassword
    version: '14'
  }
  sku: {
    name: 'Standard_B1ms'
    tier: 'GeneralPurpose'
  }
}
