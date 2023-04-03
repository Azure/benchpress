param synapseName string = 'synapse${take(uniqueString(resourceGroup().id), 5)}'
param location string = resourceGroup().location
param adlsName string = 'adls${take(uniqueString(resourceGroup().id), 5)}'
param adlsFsName string = 'fs${take(uniqueString(resourceGroup().id), 5)}'
param synapse_sqlpool_admin_username string = 'sqlAdmin'
@secure()
param synapse_sqlpool_admin_password string

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: adlsName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'

  resource synapseStorageFileSystem 'blobServices@2022-09-01' = {
    name: 'default'
    properties: {
      isVersioningEnabled: false
    }

    resource synapseStorageFileSystem2 'containers@2022-09-01' = {
      name: adlsFsName
      properties: {
        publicAccess: 'None'
      }
    }
  }
}

resource synapseWorkspace 'Microsoft.Synapse/workspaces@2021-06-01' = {
  name: synapseName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    defaultDataLakeStorage: {
      accountUrl: 'https://${storageAccount.name}.dfs.${environment().suffixes.storage}'
      filesystem: adlsFsName
    }
    managedResourceGroupName: 'mrg-${synapseName}'
    sqlAdministratorLogin: synapse_sqlpool_admin_username
    sqlAdministratorLoginPassword: synapse_sqlpool_admin_password
  }

  resource synapseFirewall1 'firewallRules@2021-06-01' = {
    name: 'AllowAllWindowsAzureIps'
    properties: {
      startIpAddress: '0.0.0.0'
      endIpAddress: '0.0.0.0'
    }
  }
  resource synapseFirewall2 'firewallrules@2021-06-01' = {
    name: 'allowAll'
    properties: {
      startIpAddress: '0.0.0.0'
      endIpAddress: '255.255.255.255'
    }
  }
}

resource synapse_sql_pool 'Microsoft.Synapse/workspaces/sqlPools@2021-06-01' = {
  parent: synapseWorkspace
  name: 'sql'
  location: location
  sku: {
    name: 'DW100c'
  }
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
  }
}

resource synapse_spark_sql_pool 'Microsoft.Synapse/workspaces/bigDataPools@2021-06-01' = {
  parent: synapseWorkspace
  name: 'spark'
  location: location
  properties: {
    isComputeIsolationEnabled: false
    nodeSizeFamily: 'MemoryOptimized'
    nodeSize: 'Small'
    autoScale: {
      enabled: true
      minNodeCount: 3
      maxNodeCount: 5
    }
    dynamicExecutorAllocation: {
      enabled: false
    }
    autoPause: {
      enabled: true
      delayInMinutes: 15
    }
    sparkVersion: '2.4'
  }
}

resource roleAssignmentStg 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(resourceGroup().id, resourceId('Microsoft.Storage/storageAccounts', storageAccount.name), synapseName)
  properties: {
    principalId: synapseWorkspace.identity.principalId
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'ba92f5b4-2d11-453d-a403-e96b0029c9fe')
    principalType: 'ServicePrincipal'
  }
  scope: storageAccount
}
