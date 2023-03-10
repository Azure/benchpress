@description('Azure Cosmos DB account name, max length 44 characters')
param docAccountName string = 'doc-${uniqueString(resourceGroup().id)}'

@description('Azure Cosmos DB account name, max length 44 characters')
param mongoAccountName string = 'mongo-${uniqueString(resourceGroup().id)}'

@description('Location for the Azure Cosmos DB account.')
param location string = resourceGroup().location

@description('The primary region for the Azure Cosmos DB account.')
param primaryRegion string = 'eastus'

@description('The secondary region for the Azure Cosmos DB account.')
param secondaryRegion string = 'eastus2'

@description('The name for the database')
param gremlinDatabaseName string = 'your-gremlin-db-name'

@description('The name for the database')
param mongoDBDatabaseName string = 'your-mongodb-db-name'

@description('The name for the database')
param sqlDatabaseName string = 'your-sql-db-name'

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

resource doc_account 'Microsoft.DocumentDB/databaseAccounts@2022-05-15' = {
  name: toLower(docAccountName)
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
  name: '${doc_account.name}/${sqlDatabaseName}'
  properties: {
    resource: {
      id: sqlDatabaseName
    }
  }
}

resource gremlin_database 'Microsoft.DocumentDB/databaseAccounts/gremlinDatabases@2022-05-15' = {
  name: '${doc_account.name}/${gremlinDatabaseName}'
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
