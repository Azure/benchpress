BeforeAll {
  Import-Module Az.InfrastructureTesting
}

$gremlinAccountName = "gremlin-account-name"
$gremlinDatabaseName = "gremlin-db-name"
$mongoAccountName = "mongodb-account-name"
$mongoDatabaseName = "mongodb-db-name"
$sqlAccountName = "sql-account-name"
$sqlDatabaseName = "sql-db-name"
$rgName = "testrg"

Describe 'Verify Cosmos DB Account with Confirm-AzBPResource' {
  it 'Should contain a Cosmos DB Account named gremlin-account-name' {
    #arrange
    $params = @{
      ResourceType      = "CosmosDBAccount"
      ResourceName      = $gremlingAccountResourceName
      ResourceGroupName = $rgName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain a Cosmos DB Account named gremlin-account-name with kind GlobalDocumentDB' {
    #arrange
    $params = @{
      ResourceType      = "CosmosDBAccount"
      ResourceName      = $gremlinAccountName
      ResourceGroupName = $rgName
      PropertyKey       = "Kind"
      PropertyValue     = "GlobalDocumentDB"
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

#######################################################################################################################

  it 'Should contain a Cosmos DB named gremlin-database-name' {
    #arrange
    $params = @{
      ResourceType      = "CosmosDBGremlinDatabase"
      ResourceName      = gremlinDatabaseName
      ResourceGroupName = $rgName
      AccountName       = $gremlinAccountName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain a Cosmos DB named gremlin-database-name' {
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
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

#######################################################################################################################

  it 'Should contain a Cosmos DB named mongodb-db-name' {
    #arrange
    $params = @{
      ResourceType      = "CosmosDBMongoDBDatabase"
      ResourceName      = $mongoDatabaseName
      ResourceGroupName = $rgName
      AccountName       = $mongoAccountName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain a Cosmos DB named mongodb-db-name with id mongodb-db-name' {
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
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

#######################################################################################################################

  it 'Should contain a Cosmos DB named sql-db-name' {
    #arrange
    $params = @{
      ResourceType      = "CosmosDBSQLDatabase"
      ResourceName      = $sqlDatabaseName
      ResourceGroupName = $rgName
      AccountName       = $sqlAccountName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain a Cosmos DB named sql-db-name with id sql-db-name' {
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
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }
}

Describe 'Comsos DB Gremlin Database' {
  It 'Should contain a Cosmos DB account with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      Name              = $gremlinAccountName
    }

    #act
    $result = Confirm-AzBPCosmosDBAccount @params

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should not contain a Cosmos DB account with the given name' {
    #arrange
    # The 'ErrorAction = SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      Name              = "nocdbbenchpresstest"
      ErrorAction       = "SilentlyContinue"
    }

    #act
    $result = Confirm-AzBPCosmosDBAccount @params

    #assert
    $result.Success | Should -Be $false
  }

  It 'Should deploy a Cosmos DB Account named `gremlin-account-name`' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      Name              = $gremlinAccountName
    }

    #act
    $result = Confirm-AzBPCosmosDBAccount @params

    #assert
    $result | Should -BeDeployed
  }

  It 'Should create a Cosmos DB Account named `gremlin-account-name` in the `eastus` location' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      Name              = $gremlinAccountName
    }

    #act
    $result = Confirm-AzBPCosmosDBAccount @params

    #assert
    $result | Should -BeInLocation 'eastus'
  }

  It 'Should contain a Cosmos DB Account named `gremlin-account-name` in `rg-test` resource group' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      Name              = $gremlinAccountName
    }

    #act
    $result = Confirm-AzBPCosmosDBAccount @params

    #assert
    $result | Should -BeInResourceGroup $rgName
  }

#######################################################################################################################

  It 'Should contain a Cosmos DB Gremlin database with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $gremlinAccountName
      Name              = $gremlinDatabaseName
    }

    #act
    $result = Confirm-AzBPCosmosDBGremlinDatabase @params

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should not contain a Cosmos DB Gremlin database with the given name' {
    #arrange
    # The 'ErrorAction = SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $gremlinAccountName
      Name              = "nocdbgdatabase"
      ErrorAction       = "SilentlyContinue"
    }

    #act
    $result = Confirm-AzBPCosmosDBGremlinDatabase @params

    #assert
    $result.Success | Should -Be $false
  }

  It 'Should deploy a Cosmos DB Gremlin Database named `gremlin-db-name`' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $gremlinAccountName
      Name              = $gremlinDatabaseName
    }

    #act
    $result = Confirm-AzBPCosmosDBGremlinDatabase @params

    #assert
    $result | Should -BeDeployed
  }

  It 'Should contain a Cosmos DB Gremlin Database named `gremlin-db-name` in `rg-test` resource group' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $gremlinAccountName
      Name              = $gremlinDatabaseName
    }

    #act
    $result = Confirm-AzBPCosmosDBGremlinDatabase @params

    #assert
    $result | Should -BeInResourceGroup $rgName
  }
}

Describe 'Comsos DB Mongo DB Database' {
  # DON'T Think we need to check accounts for Mongo or SQL if the
  # Syntax is the same between all of them (Mongo, SQL and Gremlin)
  # Would recommend deleting these Confirm-AzBPCosmosDBAccount tests
  It 'Should contain a Cosmos DB account with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      Name              = $mongoAccountName
    }

    #act
    $result = Confirm-AzBPCosmosDBAccount @params

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should deploy a Cosmos DB Account named `mongodb-account-name`' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      Name              = $mongoAccountName
    }

    #act
    $result = Confirm-AzBPCosmosDBAccount @params

    #assert
    $result | Should -BeDeployed
  }

  It 'Should contain a Cosmos DB Account named `mongodb-account-name` in the `eastus` location' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      Name              = $mongoAccountName
    }

    #act
    $result = Confirm-AzBPCosmosDBAccount @params

    #assert
    $result | Should -BeInLocation 'eastus'
  }

  It 'Should contain a Cosmos DB Account named `mongodb-account-name` in `rg-test` resource group' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      Name              = $mongoAccountName
    }

    #act
    $result = Confirm-AzBPCosmosDBAccount @params

    #assert
    $result | Should -BeInResourceGroup $rgName
  }

#######################################################################################################################

  It 'Should contain a Cosmos DB Mongo DB database with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $mongoAccountName
      Name              = $mongoDatabaseName
    }

    #act
    $result = Confirm-AzBPCosmosDBMongoDBDatabase @params

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should not contain a Cosmos DB Mongo DB database with the given name' {
    #arrange
    # The 'ErrorAction = SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $mongoAccountName
      Name              = "nocdbmdbdatabase"
      ErrorAction       = "SilentlyContinue"
    }

    #act
    $result = Confirm-AzBPCosmosDBMongoDBDatabase @params

    #assert
    $result.Success | Should -Be $false
  }

  It 'Should deploy a Cosmos DB Mongo DB Database named `mongodb-db-name`' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $mongoAccountName
      Name              = $mongoDatabaseName
    }

    #act
    $result = Confirm-AzBPCosmosDBMongoDBDatabase @params

    #assert
    $result | Should -BeDeployed
  }

  It 'Should contain a Cosmos DB Mongo DB Database named `mongodb-db-name` in `rg-test` resource group' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $mongoAccountName
      Name              = $mongoDatabaseName
    }

    #act
    $result = Confirm-AzBPCosmosDBMongoDBDatabase @params

    #assert
    $result | Should -BeInResourceGroup $rgName
  }
}

Describe 'Comsos DB SQL Database' {
  It 'Should contain a Cosmos DB account with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      Name              = $sqlAccountName
    }

    #act
    $result = Confirm-AzBPCosmosDBAccount @params

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should deploy a Cosmos DB Account named `sql-account-name`' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      Name              = $sqlAccountName
    }

    #act
    $result = Confirm-AzBPCosmosDBAccount @params

    #assert
    $result | Should -BeDeployed
  }

  It 'Should contain a Cosmos DB Account named `sql-account-name` in the `eastus` location' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      Name              = $sqlAccountName
    }

    #act
    $result = Confirm-AzBPCosmosDBAccount @params

    #assert
    $result | Should -BeInLocation 'eastus'
  }

  It 'Should contain a Cosmos DB Account named `sql-account-name` in `rg-test` resource group' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      Name              = $sqlAccountName
    }

    #act
    $result = Confirm-AzBPCosmosDBAccount @params

    #assert
    $result | Should -BeInResourceGroup $rgName
  }

#######################################################################################################################

  It 'Should contain a Cosmos DB SQL database with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $sqlAccountName
      Name              = $sqlDatabaseName
    }

    #act
    $result = Confirm-AzBPCosmosDBSqlDatabase @params

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should not contain a Cosmos DB SQL database with the given name' {
    #arrange
    # The 'ErrorAction = SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $sqlAccountName
      Name              = "nocdbsqldatabase"
      ErrorAction       = "SilentlyContinue"
    }

    #act
    $result = Confirm-AzBPCosmosDBSqlDatabase @params

    #assert
    $result.Success | Should -Be $false
  }

  It 'Should deploy a Cosmos DB SQL Database named `sql-db-name`' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $sqlAccountName
      Name              = $sqlDatabaseName
    }

    #act
    $result = Confirm-AzBPCosmosDBSqlDatabase @params

    #assert
    $result | Should -BeDeployed
  }

  It 'Should contain a Cosmos DB SQL Database named `sql-db-name` in `rg-test` resource group' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $sqlAccountName
      Name              = $sqlDatabaseName
    }

    #act
    $result = Confirm-AzBPCosmosDBSqlDatabase @params

    #assert
    $result | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module -Name BenchPress.Azure | Remove-Module
}
