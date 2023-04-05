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

@description('Service Principal Object Id')
param principalId string

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

var roleDefinitionId = guid('sql-role-definition-', principalId, sql_account.id)
var roleAssignmentId = guid(roleDefinitionId, principalId, sql_account.id)

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

resource database 'Microsoft.DocumentDB/databaseAccounts/mongodbDatabases@2022-05-15' = {
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

resource sqlRoleAssignment 'Microsoft.DocumentDB/databaseAccounts/sqlRoleAssignments@2021-04-15' = {
  name: '${sql_account.name}/${roleAssignmentId}'
  properties: {
    roleDefinitionId: '${sql_account.name}/${roleDefinitionId}'
    principalId: principalId
    scope: sql_account.id
  }
}
