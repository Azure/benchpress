BeforeAll {
  Import-Module Az-InfrastructureTest
}

Describe 'Cosmos DB Account' {
  It 'Should contain a Cosmos DB account with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-name"
      Name              = "account-name"
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
      ResourceGroupName = "rg-name"
      Name              = "nocdbbenchpresstest"
      ErrorAction       = SilentlyContinue
    }

    #act
    $result = Confirm-AzBPCosmosDBAccount @params

    #assert
    $result.Success | Should -Be $false
  }

  It 'Should contain a Cosmos DB Account named `account-name`' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-name"
      Name              = "account-name"
    }

    #act
    $result = Confirm-AzBPCosmosDBAccount @params

    #assert
    $result | Should -BeDeployed
  }

  It 'Should contain a Cosmos DB Account named `account-name` in the `global` location' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-name"
      Name              = "account-name"
    }

    #act
    $result = Confirm-AzBPCosmosDBAccount @params

    #assert
    $result | Should -BeInLocation 'global'
  }

  It 'Should contain a Cosmos DB Account named `account-name` in `rg-name` resource group' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-name"
      Name              = "account-name"
    }

    #act
    $result = Confirm-AzBPCosmosDBAccount @params

    #assert
    $result | Should -BeInResourceGroup 'rg-name'
  }
}

Describe 'Comsos DB Gremlin Database' {
  It 'Should contain a Cosmos DB Gremlin database with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-name"
      AccountName       = "account-name"
      Name              = "gremlin-db-name"
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
      ResourceGroupName = "rg-name"
      AccountName       = "account-name"
      Name              = "nocdbgdatabase"
      ErrorAction       = SilentlyContinue
    }

    #act
    $result = Confirm-AzBPCosmosDBGremlinDatabase @params

    #assert
    $result.Success | Should -Be $false
  }

  It 'Should contain a Cosmos DB Gremlin Database named `gremlin-db-name`' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-name"
      AccountName       = "account-name"
      Name              = "gremlin-db-name"
    }

    #act
    $result = Confirm-AzBPCosmosDBGremlinDatabase @params

    #assert
    $result | Should -BeDeployed
  }

  It 'Should contain a Cosmos DB Gremlin Database named `gremlin-db-name` in the `global` location' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-name"
      AccountName       = "account-name"
      Name              = "gremlin-db-name"
    }

    #act
    $result = Confirm-AzBPCosmosDBGremlinDatabase @params

    #assert
    $result | Should -BeInLocation 'global'
  }

  It 'Should contain a Cosmos DB Gremlin Database named `gremlin-db-name` in `rg-name` resource group' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-name"
      AccountName       = "account-name"
      Name              = "gremlin-db-name"
    }

    #act
    $result = Confirm-AzBPCosmosDBGremlinDatabase @params

    #assert
    $result | Should -BeInResourceGroup 'rg-name'
  }
}

Describe 'Comsos DB Mongo DB Database' {
  It 'Should contain a Cosmos DB Mongo DB database with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-name"
      AccountName       = "account-name"
      Name              = "mongodb-db-name"
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
      ResourceGroupName = "rg-name"
      AccountName       = "account-name"
      Name              = "nocdbmdbdatabase"
      ErrorAction       = SilentlyContinue
    }

    #act
    $result = Confirm-AzBPCosmosDBMongoDBDatabase @params

    #assert
    $result.Success | Should -Be $false
  }

  It 'Should contain a Cosmos DB Mongo DB Database named `mongodb-db-name`' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-name"
      AccountName       = "account-name"
      Name              = "mongodb-db-name"
    }

    #act
    $result = Confirm-AzBPCosmosDBMongoDBDatabase @params

    #assert
    $result | Should -BeDeployed
  }

  It 'Should contain a Cosmos DB Mongo DB Database named `mongodb-db-name` in the `global` location' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-name"
      AccountName       = "account-name"
      Name              = "mongodb-db-name"
    }

    #act
    $result = Confirm-AzBPCosmosDBMongoDBDatabase @params

    #assert
    $result | Should -BeInLocation 'global'
  }

  It 'Should contain a Cosmos DB Mongo DB Database named `mongodb-db-name` in `rg-name` resource group' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-name"
      AccountName       = "account-name"
      Name              = "mongodb-db-name"
    }

    #act
    $result = Confirm-AzBPCosmosDBMongoDBDatabase @params

    #assert
    $result | Should -BeInResourceGroup 'rg-name'
  }
}

Describe 'Comsos DB SQL Database' {
  It 'Should contain a Cosmos DB SQL database with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-name"
      AccountName       = "account-name"
      Name              = "sql-db-name"
    }

    #act
    $result = Confirm-AzBPCosmosDBSqlDatabase @params

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should not contain a Cosmos DB SQL database with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-name"
      AccountName       = "account-name"
      Name              = "nocdbsqldatabase"
    }

    #act
    $result = Confirm-AzBPCosmosDBSqlDatabase @params

    #assert
    $result.Success | Should -Be $false
  }

  It 'Should contain a Cosmos DB SQL Database named `sql-db-name`' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-name"
      AccountName       = "account-name"
      Name              = "sql-db-name"
    }

    #act
    $result = Confirm-AzBPCosmosDBSqlDatabase @params

    #assert
    $result | Should -BeDeployed
  }

  It 'Should contain a Cosmos DB SQL Database named `sql-db-name` in the `global` location' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-name"
      AccountName       = "account-name"
      Name              = "sql-db-name"
    }

    #act
    $result = Confirm-AzBPCosmosDBSqlDatabase @params

    #assert
    $result | Should -BeInLocation 'global'
  }

  It 'Should contain a Cosmos DB SQL Database named `sql-db-name` in `rg-name` resource group' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-name"
      AccountName       = "account-name"
      Name              = "sql-db-name"
    }

    #act
    $result = Confirm-AzBPCosmosDBSqlDatabase @params

    #assert
    $result | Should -BeInResourceGroup 'rg-name'
  }
}
