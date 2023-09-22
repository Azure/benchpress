@description('Azure Cosmos DB account name, max length 44 characters')
param gremlinAccountName string = 'gremlin-${uniqueString(resourceGroup().id)}'

@description('The name for the database')
param gremlinDatabaseName string = 'gremlin-db-name'

@description('Azure Cosmos DB account name, max length 44 characters')
param mongoAccountName string = 'mongo-${uniqueString(resourceGroup().id)}'

@description('The name for the database')
param mongoDBDatabaseName string = 'mongodb-db-name'

@description('Azure Cosmos DB account name, max length 44 characters')
param sqlAccountName string = 'sql-${uniqueString(resourceGroup().id)}'

@description('The name for the database')
param sqlDatabaseName string = 'sql-db-name'

@description('Location for the Azure Cosmos DB account.')
param location string = resourceGroup().location

@description('The primary region for the Azure Cosmos DB account.')
param primaryRegion string = 'eastus'

@description('The secondary region for the Azure Cosmos DB account.')
param secondaryRegion string = 'eastus2'

@description('Data actions permitted by the Role Definition')
param dataActions array = [
  'Microsoft.DocumentDB/databaseAccounts/readMetadata'
  'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/items/*'
]

@description('Service Principal Object Id')
param svcPrincipalObjectId string

@description('Friendly name for the SQL Role Definition')
param roleDefinitionName string = 'My Read Write Role'

var locations = [
  {
    locationName: primaryRegion
    failoverPriority: 0
    isZoneRedundant: false
  }
  {
    locationName: secondaryRegion
    failoverPriority: 1
    isZoneRedundant: false
  }
]

var roleDefinitionId = guid('sql-role-definition-', svcPrincipalObjectId, sql_account.id)
var roleAssignmentId = guid(roleDefinitionId, svcPrincipalObjectId, sql_account.id)

resource gremlin_account 'Microsoft.DocumentDB/databaseAccounts@2022-05-15' = {
  name: toLower(gremlinAccountName)
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    capabilities: [
      {
        name: 'EnableGremlin'
      }
    ]
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
    }
    locations: locations
    databaseAccountOfferType: 'Standard'
    enableAutomaticFailover: true
  }
}

resource gremlin_database 'Microsoft.DocumentDB/databaseAccounts/gremlinDatabases@2022-05-15' = {
  name: '${gremlin_account.name}/${gremlinDatabaseName}'
  properties: {
    resource: {
      id: gremlinDatabaseName
    }
  }
}

resource mongo_account 'Microsoft.DocumentDB/databaseAccounts@2022-05-15' = {
  name: toLower(mongoAccountName)
  location: location
  kind: 'MongoDB'
  properties: {
    consistencyPolicy: {
      defaultConsistencyLevel: 'Eventual'
    }
    locations: locations
    databaseAccountOfferType: 'Standard'
    enableAutomaticFailover: true
    apiProperties: {
      serverVersion: '4.2'
    }
    capabilities: [
      {
        name: 'DisableRateLimitingResponses'
      }
    ]
  }
}

resource mongo_database 'Microsoft.DocumentDB/databaseAccounts/mongodbDatabases@2022-05-15' = {
  parent: mongo_account
  name: mongoDBDatabaseName
  properties: {
    resource: {
      id: mongoDBDatabaseName
    }
    options: {
      autoscaleSettings: {
        maxThroughput: 1000
      }
    }
  }
}

resource sql_account 'Microsoft.DocumentDB/databaseAccounts@2022-05-15' = {
  name: toLower(sqlAccountName)
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
    }
    locations: locations
    databaseAccountOfferType: 'Standard'
    enableAutomaticFailover: true
  }
}

resource sql_database 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2022-05-15' = {
  name: '${sql_account.name}/${sqlDatabaseName}'
  properties: {
    resource: {
      id: sqlDatabaseName
    }
  }
}

resource sqlRoleDefinition 'Microsoft.DocumentDB/databaseAccounts/sqlRoleDefinitions@2022-11-15' = {
  name: '${sql_account.name}/${roleDefinitionId}'
  properties: {
    roleName: roleDefinitionName
    type: 'CustomRole'
    assignableScopes: [
      sql_account.id
    ]
    permissions: [
      {
        dataActions: dataActions
      }
    ]
  }
}

resource sqlRoleAssignment 'Microsoft.DocumentDB/databaseAccounts/sqlRoleAssignments@2022-11-15' = {
  name: '${sql_account.name}/${roleAssignmentId}'
  properties: {
    roleDefinitionId: sqlRoleDefinition.id
    principalId: svcPrincipalObjectId
    scope: sql_account.id
  }
}
