BeforeAll {
  Import-Module BenchPress.Azure
}

Describe 'Comsos DB Gremlin Database' {
  It 'Should contain a Cosmos DB account with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-test"
      Name              = "gremlin-account-name"
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
      ResourceGroupName = "rg-test"
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
      ResourceGroupName = "rg-test"
      Name              = "gremlin-account-name"
    }

    #act
    $result = Confirm-AzBPCosmosDBAccount @params

    #assert
    $result | Should -BeDeployed
  }

  It 'Should create a Cosmos DB Account named `gremlin-account-name` in the `eastus` location' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-test"
      Name              = "gremlin-account-name"
    }

    #act
    $result = Confirm-AzBPCosmosDBAccount @params

    #assert
    $result | Should -BeInLocation 'eastus'
  }

  It 'Should contain a Cosmos DB Account named `gremlin-account-name` in `rg-test` resource group' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-test"
      Name              = "gremlin-account-name"
    }

    #act
    $result = Confirm-AzBPCosmosDBAccount @params

    #assert
    $result | Should -BeInResourceGroup 'rg-test'
  }

  It 'Should contain a Cosmos DB Gremlin database with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-test"
      AccountName       = "gremlin-account-name"
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
      ResourceGroupName = "rg-test"
      AccountName       = "gremlin-account-name"
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
      ResourceGroupName = "rg-test"
      AccountName       = "gremlin-account-name"
      Name              = "gremlin-db-name"
    }

    #act
    $result = Confirm-AzBPCosmosDBGremlinDatabase @params

    #assert
    $result | Should -BeDeployed
  }

  It 'Should contain a Cosmos DB Gremlin Database named `gremlin-db-name` in `rg-test` resource group' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-test"
      AccountName       = "gremlin-account-name"
      Name              = "gremlin-db-name"
    }

    #act
    $result = Confirm-AzBPCosmosDBGremlinDatabase @params

    #assert
    $result | Should -BeInResourceGroup 'rg-test'
  }
}

Describe 'Comsos DB Mongo DB Database' {
  It 'Should contain a Cosmos DB account with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-test"
      Name              = "mongodb-account-name"
    }

    #act
    $result = Confirm-AzBPCosmosDBAccount @params

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should deploy a Cosmos DB Account named `mongodb-account-name`' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-test"
      Name              = "mongodb-account-name"
    }

    #act
    $result = Confirm-AzBPCosmosDBAccount @params

    #assert
    $result | Should -BeDeployed
  }

  It 'Should contain a Cosmos DB Account named `mongodb-account-name` in the `eastus` location' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-test"
      Name              = "mongodb-account-name"
    }

    #act
    $result = Confirm-AzBPCosmosDBAccount @params

    #assert
    $result | Should -BeInLocation 'eastus'
  }

  It 'Should contain a Cosmos DB Account named `mongodb-account-name` in `rg-test` resource group' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-test"
      Name              = "mongodb-account-name"
    }

    #act
    $result = Confirm-AzBPCosmosDBAccount @params

    #assert
    $result | Should -BeInResourceGroup 'rg-test'
  }

  It 'Should contain a Cosmos DB Mongo DB database with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-test"
      AccountName       = "mongodb-account-name"
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
      ResourceGroupName = "rg-test"
      AccountName       = "mongodb-account-name"
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
      ResourceGroupName = "rg-test"
      AccountName       = "mongodb-account-name"
      Name              = "mongodb-db-name"
    }

    #act
    $result = Confirm-AzBPCosmosDBMongoDBDatabase @params

    #assert
    $result | Should -BeDeployed
  }

  It 'Should contain a Cosmos DB Mongo DB Database named `mongodb-db-name` in `rg-test` resource group' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-test"
      AccountName       = "mongodb-account-name"
      Name              = "mongodb-db-name"
    }

    #act
    $result = Confirm-AzBPCosmosDBMongoDBDatabase @params

    #assert
    $result | Should -BeInResourceGroup 'rg-test'
  }
}

Describe 'Comsos DB SQL Database' {
  It 'Should contain a Cosmos DB account with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-test"
      Name              = "sql-account-name"
    }

    #act
    $result = Confirm-AzBPCosmosDBAccount @params

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should deploy a Cosmos DB Account named `sql-account-name`' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-test"
      Name              = "sql-account-name"
    }

    #act
    $result = Confirm-AzBPCosmosDBAccount @params

    #assert
    $result | Should -BeDeployed
  }

  It 'Should contain a Cosmos DB Account named `sql-account-name` in the `eastus` location' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-test"
      Name              = "sql-account-name"
    }

    #act
    $result = Confirm-AzBPCosmosDBAccount @params

    #assert
    $result | Should -BeInLocation 'eastus'
  }

  It 'Should contain a Cosmos DB Account named `sql-account-name` in `rg-test` resource group' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-test"
      Name              = "sql-account-name"
    }

    #act
    $result = Confirm-AzBPCosmosDBAccount @params

    #assert
    $result | Should -BeInResourceGroup 'rg-test'
  }

  It 'Should contain a Cosmos DB SQL database with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-test"
      AccountName       = "sql-account-name"
      Name              = "sql-db-name"
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
      ResourceGroupName = "rg-test"
      AccountName       = "sql-account-name"
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
      ResourceGroupName = "rg-test"
      AccountName       = "sql-account-name"
      Name              = "sql-db-name"
    }

    #act
    $result = Confirm-AzBPCosmosDBSqlDatabase @params

    #assert
    $result | Should -BeDeployed
  }

  It 'Should contain a Cosmos DB SQL Database named `sql-db-name` in `rg-test` resource group' {
    #arrange
    $params = @{
      ResourceGroupName = "rg-test"
      AccountName       = "sql-account-name"
      Name              = "sql-db-name"
    }

    #act
    $result = Confirm-AzBPCosmosDBSqlDatabase @params

    #assert
    $result | Should -BeInResourceGroup 'rg-test'
  }
}

AfterAll {
  Get-Module -Name BenchPress.Azure | Remove-Module
}
