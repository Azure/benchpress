BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:location = 'westus3'
  $Script:gremlinAccountName = "gremlin-account-name"
  $Script:gremlinDatabaseName = "gremlin-db-name"
  $Script:mongoAccountName = "mongodb-account-name"
  $Script:mongoDatabaseName = "mongodb-db-name"
  $Script:sqlAccountName = "sql-account-name"
  $Script:sqlDatabaseName = "sql-db-name"
}

Describe 'Verify Cosmos DB Account' {
  It "Should contain a Gremlin Cosmos DB Account named $gremlinAccountName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "CosmosDBAccount"
      ResourceName      = $gremlinAccountName
      ResourceGroupName = $rgName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Gremlin Cosmos DB Account named $gremlinAccountName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "CosmosDBAccount"
      ResourceName      = $gremlinAccountName
      ResourceGroupName = $rgName
      PropertyKey       = "Kind"
      PropertyValue     = "GlobalDocumentDB"
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Gremlin Cosmos DB named $gremlinDatabaseName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "CosmosDBGremlinDatabase"
      ResourceName      = $gremlinDatabaseName
      ResourceGroupName = $rgName
      AccountName       = $gremlinAccountName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Gremlin Cosmos DB named $gremlinDatabaseName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "CosmosDBGremlinDatabase"
      ResourceName      = $gremlinDatabaseName
      ResourceGroupName = $rgName
      AccountName       = $gremlinAccountName
      PropertyKey       = "Id"
      PropertyValue     = $gremlinDatabaseName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

#######################################################################################################################

  It "Should contain a Mongo Cosmos DB Account named $mongoAccountName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "CosmosDBAccount"
      ResourceName      = $mongoAccountName
      ResourceGroupName = $rgName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Mongo Cosmos DB Account named $mongoAccountName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "CosmosDBAccount"
      ResourceName      = $mongoAccountName
      ResourceGroupName = $rgName
      PropertyKey       = "Kind"
      PropertyValue     = "GlobalDocumentDB"
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Mongo Cosmos DB named $mongoDatabaseName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "CosmosDBMongoDBDatabase"
      ResourceName      = $mongoDatabaseName
      ResourceGroupName = $rgName
      AccountName       = $mongoAccountName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Mongo Cosmos DB named $mongoDatabaseName- Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "CosmosDBMongoDBDatabase"
      ResourceName      = $mongoDatabaseName
      ResourceGroupName = $rgName
      AccountName       = $mongoAccountName
      PropertyKey       = "Id"
      PropertyValue     = $mongoDatabaseName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

#######################################################################################################################

  It "Should contain a SQL Cosmos DB Account named $sqlAccountName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "CosmosDBAccount"
      ResourceName      = $sqlAccountName
      ResourceGroupName = $rgName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a SQL Cosmos DB Account named $sqlAccountName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "CosmosDBAccount"
      ResourceName      = $sqlAccountName
      ResourceGroupName = $rgName
      PropertyKey       = "Kind"
      PropertyValue     = "GlobalDocumentDB"
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a SQL Cosmos DB named $sqlDatabaseName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "CosmosDBSQLDatabase"
      ResourceName      = $sqlDatabaseName
      ResourceGroupName = $rgName
      AccountName       = $sqlAccountName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a SQL Cosmos DB named $sqlDatabaseName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "CosmosDBSQLDatabase"
      ResourceName      = $sqlDatabaseName
      ResourceGroupName = $rgName
      AccountName       = $sqlAccountName
      PropertyKey       = "Id"
      PropertyValue     = $sqlDatabaseName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }
}

Describe 'Cosmos DB Gremlin Database' {
  BeforeAll {
    $Script:noGremlinDBAccountName = 'nocdbbenchpresstest'
    $Script:noGremlinDBName = 'nocdatabasebenchpresstest'
  }

  It "Should contain a Cosmos DB Account named $gremlinAccountName" {
    Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $gremlinAccountName | Should -BeSuccessful
  }

  It "Should not contain a Cosmos DB account named $noGremlinDBAccountName" {
    #arrange
    # The 'ErrorAction = SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      Name              = $noGremlinDBAccountName
      ErrorAction       = "SilentlyContinue"
    }

    #act
    Confirm-AzBPCosmosDBAccount @params | Should -Not -BeSuccessful
  }

  It "Should contain a Cosmos DB Account named $gremlinAccountName in $location" {
    Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $gremlinAccountName | Should -BeInLocation $location
  }

  It "Should contain a Cosmos DB Account named $gremlinAccountName in $rgName" {
    Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $gremlinAccountName
    | Should -BeInResourceGroup $rgName
  }

#######################################################################################################################

  It "Should contain a Cosmos DB Gremlin Database named $gremlinDatabaseName" {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $gremlinAccountName
      Name              = $gremlinDatabaseName
    }

    #act
    Confirm-AzBPCosmosDBGremlinDatabase @params | Should -BeSuccessful
  }

  It "Should not contain a Cosmos DB Gremlin Database named $noGremlinDBName" {
    #arrange
    # The 'ErrorAction = SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $gremlinAccountName
      Name              = $noGremlinDBName
      ErrorAction       = "SilentlyContinue"
    }

    #act
    Confirm-AzBPCosmosDBGremlinDatabase @params | Should -Not -BeSuccessful
  }

  It "Should contain a Cosmos DB Gremlin Database named $gremlinDatabaseName in $location" {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $gremlinAccountName
      Name              = $gremlinDatabaseName
    }

    #act
    Confirm-AzBPCosmosDBGremlinDatabase @params | Should -BeInLocation $location
  }

  It "Should contain a Cosmos DB Gremlin Database named $gremlinDatabaseName in $rgName" {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $gremlinAccountName
      Name              = $gremlinDatabaseName
    }

    #act
    Confirm-AzBPCosmosDBGremlinDatabase @params | Should -BeInResourceGroup $rgName
  }
}

Describe 'Comsos DB Mongo DB Database' {
  BeforeAll {
    $Script:noMongoDBAccountName = 'nomdbbenchpresstest'
    $Script:noMongoDBName = 'nomdatabasebenchpresstest'
  }

  It "Should contain a Cosmos DB Account named $mongoAccountName" {
    Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $mongoAccountName | Should -BeSuccessful
  }

  It "Should not contain a Cosmos DB Account named $noMongoDBAccountName" {
    #arrange
    # The 'ErrorAction = SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      Name              = $noMongoDBAccountName
      ErrorAction       = "SilentlyContinue"
    }

    #act
    Confirm-AzBPCosmosDBAccount @params | Should -Not -BeSuccessful
  }

  It "Should contain a Cosmos DB Account named $mongoAccountName in $location" {
    Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $mongoAccountName | Should -BeInLocation $location
  }

  It "Should contain a Cosmos DB Account named $mongoAccountName in $rgName" {
    Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $mongoAccountName | Should -BeInResourceGroup $rgName
  }

#######################################################################################################################

  It "Should contain a Cosmos DB Mongo DB Database named $mongoDatabaseName" {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $mongoAccountName
      Name              = $mongoDatabaseName
    }

    #act
    Confirm-AzBPCosmosDBMongoDBDatabase @params | Should -BeSuccessful
  }

  It "Should not contain a Cosmos DB Mongo DB Database named $noMongoDBName" {
    #arrange
    # The 'ErrorAction = SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $mongoAccountName
      Name              = $noMongoDBName
      ErrorAction       = "SilentlyContinue"
    }

    #act
    Confirm-AzBPCosmosDBMongoDBDatabase @params | Should -Not -BeSuccessful
  }

  It "Should contain a Cosmos DB Mongo DB Database named $mongoDatabaseName in $location" {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $mongoAccountName
      Name              = $mongoDatabaseName
    }

    #act
    Confirm-AzBPCosmosDBMongoDBDatabase @params | Should -BeInLocation $location
  }

  It "Should contain a Cosmos DB Mongo DB Database named $mongoDatabaseName in $rgName" {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $mongoAccountName
      Name              = $mongoDatabaseName
    }

    #act
    Confirm-AzBPCosmosDBMongoDBDatabase @params | Should -BeInResourceGroup $rgName
  }
}

Describe 'Comsos DB SQL Database' {
  BeforeAll {
    $Script:noSqlAccountName = 'nosqlbenchpresstest'
    $Script:noSqlDatabaseName = 'nosqldatabasebenchpresstest'
  }

  It "Should contain a Cosmos DB Account named $sqlAccountName" {
    Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $sqlAccountName | Should -BeSuccessful
  }

  It "Should not contain a Cosmos DB Account named $noSqlAccountName" {
    #arrange
    # The 'ErrorAction = SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      Name              = $noSqlAccountName
      ErrorAction       = "SilentlyContinue"
    }

    #act
    Confirm-AzBPCosmosDBAccount @params | Should -Not -BeSuccessful
  }

  It "Should contain a Cosmos DB Account named $sqlAccountName in $location" {
    Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $sqlAccountName | Should -BeInLocation $location
  }

  It "Should contain a Cosmos DB Account named $sqlAccountName in $rgName" {
    Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $sqlAccountName | Should -BeInResourceGroup $rgName
  }

#######################################################################################################################

  It "Should contain a Cosmos DB SQL Database named $sqlDatabaseName" {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $sqlAccountName
      Name              = $sqlDatabaseName
    }

    #act
    Confirm-AzBPCosmosDBSqlDatabase @params | Should -BeSuccessful
  }

  It "Should not contain a Cosmos DB SQL Database named $noSqlDBName" {
    #arrange
    # The 'ErrorAction = SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $sqlAccountName
      Name              = $noSqlDBName
      ErrorAction       = "SilentlyContinue"
    }

    #act
    Confirm-AzBPCosmosDBSqlDatabase @params | Should -Not -BeSuccessful
  }

  It "Should contain a Cosmos DB SQL Database named $sqlDatabaseName in $location" {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $sqlAccountName
      Name              = $sqlDatabaseName
    }

    #act
    Confirm-AzBPCosmosDBSqlDatabase @params | Should -BeInLocation $location
  }

  It "Should contain a Cosmos DB SQL Database named $sqlDatabaseName in $rgName" {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $sqlAccountName
      Name              = $sqlDatabaseName
    }

    #act
    Confirm-AzBPCosmosDBSqlDatabase @params | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
