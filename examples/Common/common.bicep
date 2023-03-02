param location string = 'westus3'
param svcPrincipalObjectId string
@secure()
param vmAdminPasswordOrKey string
@secure()
param sqlAdminPassword string

module virtualmachine '../VirtualMachine/virtualMachine.bicep' = {
  name: 'virtual_machine'
  params: {
    location: location
    adminPasswordOrKey: vmAdminPasswordOrKey
  }
}

module containerregistry '../ContainerRegistry/containerRegistry.bicep' = {
  name: 'container_registry'
  params: {
    location: location
  }
}

module azuresql '../SqlDatabase/sqldatabase.bicep' = {
  name: 'azure_sql'
  params: {
    location: location
    adminPassword: sqlAdminPassword
  }
}

module keyvault '../KeyVault/keyVault.bicep' = {
  name: 'key_vault'
  params: {
    location: location
    svcPrincipalObjectId: svcPrincipalObjectId
  }
}
