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
  It "Should contain a gremlin Cosmos DB Account named $gremlinAccountName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "CosmosDBAccount"
      ResourceName      = $gremlinAccountName
      ResourceGroupName = $rgName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain a gremlin Cosmos DB Account named $gremlinAccountName - Confirm-AzBPResource" {
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

  It "Should contain a gremlin Cosmos DB named $gremlinDatabaseName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "CosmosDBGremlinDatabase"
      ResourceName      = $gremlinDatabaseName
      ResourceGroupName = $rgName
      AccountName       = $gremlinAccountName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain a gremlin Cosmos DB named $gremlinDatabaseName - Confirm-AzBPResource" {
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

  It "Should contain a mongo Cosmos DB Account named $mongoAccountName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "CosmosDBAccount"
      ResourceName      = $mongoAccountName
      ResourceGroupName = $rgName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain a mongo Cosmos DB Account named $mongoAccountName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "CosmosDBAccount"
      ResourceName      = $mongoAccountName
      ResourceGroupName = $rgName
      PropertyKey       = "Kind"
      PropertyValue     = "GlobalDocumentDB"
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain a mongo Cosmos DB named $mongoDatabaseName - Confirm-AzBPResource" {
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

  It "Should contain a mongo Cosmos DB named $mongoDatabaseName- Confirm-AzBPResource" {
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

  It "Should contain a sql Cosmos DB Account named $sqlAccountName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "CosmosDBAccount"
      ResourceName      = $sqlAccountName
      ResourceGroupName = $rgName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain a sql Cosmos DB Account named $sqlAccountName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "CosmosDBAccount"
      ResourceName      = $sqlAccountName
      ResourceGroupName = $rgName
      PropertyKey       = "Kind"
      PropertyValue     = "GlobalDocumentDB"
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain a sql Cosmos DB named $sqlDatabaseName - Confirm-AzBPResource" {
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

  It "Should contain a sql Cosmos DB named $sqlDatabaseName - Confirm-AzBPResource" {
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

Describe 'Cosmos DB Gremlin Database' {
  BeforeAll {
    $Script:noGremlinDBAccountName = 'nocdbbenchpresstest'
    $Script:noGremlinDBName = 'nocdatabasebenchpresstest'
  }

  It 'Should contain a Cosmos DB account with the given name' {
    #act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $gremlinAccountName

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
      Name              = $noGremlinDBAccountName
      ErrorAction       = "SilentlyContinue"
    }

    #act
    $result = Confirm-AzBPCosmosDBAccount @params

    #assert
    $result.Success | Should -Be $false
  }

  It "Should deploy a Cosmos DB Account named $gremlinAccountName" {
    #act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $gremlinAccountName

    #assert
    $result | Should -BeDeployed
  }

  It "Should contain a Cosmos DB Account named $gremlinAccountName in $location" {
    #act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $gremlinAccountName

    #assert
    $result | Should -BeInLocation $location
  }

  It "Should contain a Cosmos DB Account named $gremlinAccountName in $rgName" {
    #act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $gremlinAccountName

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
      Name              = $noGremlinDBName
      ErrorAction       = "SilentlyContinue"
    }

    #act
    $result = Confirm-AzBPCosmosDBGremlinDatabase @params

    #assert
    $result.Success | Should -Be $false
  }

  It "Should deploy a Cosmos DB Gremlin Database named $gremlinDatabaseName" {
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

  It "Should contain a Cosmos DB Gremlin Database named $gremlinDatabaseName in $location" {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $gremlinAccountName
      Name              = $gremlinDatabaseName
    }

    #act
    $result = Confirm-AzBPCosmosDBGremlinDatabase @params

    #assert
    $result | Should -BeInLocation $location
  }

  It "Should contain a Cosmos DB Gremlin Database named $gremlinDatabaseName in $rgName" {
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
  BeforeAll {
    $Script:noMongoDBAccountName = 'nomdbbenchpresstest'
    $Script:noMongoDBName = 'nomdatabasebenchpresstest'
  }

  It 'Should contain a Cosmos DB account with the given name' {
    #act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $mongoAccountName

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should not contain a Cosmos DB Mongo account with the given name' {
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
    $result = Confirm-AzBPCosmosDBAccount @params

    #assert
    $result.Success | Should -Be $false
  }

  It "Should deploy a Cosmos DB Account named $mongoAccountName" {
    #act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $mongoAccountName

    #assert
    $result | Should -BeDeployed
  }

  It "Should contain a Cosmos DB Account named $mongoAccountName in $location" {
    #act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $mongoAccountName

    #assert
    $result | Should -BeInLocation $location
  }

  It "Should contain a Cosmos DB Account named $mongoAccountName in $rgName" {
    #act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $mongoAccountName

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
      Name              = $noMongoDBName
      ErrorAction       = "SilentlyContinue"
    }

    #act
    $result = Confirm-AzBPCosmosDBMongoDBDatabase @params

    #assert
    $result.Success | Should -Be $false
  }

  It "Should deploy a Cosmos DB Mongo DB Database named $mongoDatabaseName" {
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

  It "Should contain a Cosmos DB Mongo DB Database named $mongoDatabaseName in $location" {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $mongoAccountName
      Name              = $mongoDatabaseName
    }

    #act
    $result = Confirm-AzBPCosmosDBMongoDBDatabase @params

    #assert
    $result | Should -BeInLocation $location
  }

  It "Should contain a Cosmos DB Mongo DB Database named $mongoDatabaseName in $rgName" {
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
  BeforeAll {
    $Script:noSqlAccountName = 'nosqlbenchpresstest'
    $Script:noSqlDatabaseName = 'nosqldatabasebenchpresstest'
  }

  It 'Should contain a Cosmos DB account with the given name' {
    #act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $sqlAccountName

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should not contain a Cosmos DB SQL account with the given name' {
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
    $result = Confirm-AzBPCosmosDBAccount @params

    #assert
    $result.Success | Should -Be $false
  }

  It "Should deploy a Cosmos DB Account named $sqlAccountName" {
    #act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $sqlAccountName

    #assert
    $result | Should -BeDeployed
  }

  It "Should contain a Cosmos DB Account named $sqlAccountName in $location" {
    #act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $sqlAccountName

    #assert
    $result | Should -BeInLocation $location
  }

  It "Should contain a Cosmos DB Account named $sqlAccountName in $rgName" {
    #act
    $result = Confirm-AzBPCosmosDBAccount -ResourceGroupName $rgName -Name $sqlAccountName

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
      Name              = $noSqlDBName
      ErrorAction       = "SilentlyContinue"
    }

    #act
    $result = Confirm-AzBPCosmosDBSqlDatabase @params

    #assert
    $result.Success | Should -Be $false
  }

  It "Should deploy a Cosmos DB SQL Database named $sqlDatabaseName" {
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

  It "Should contain a Cosmos DB SQL Database named $sqlDatabaseName in $location" {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $sqlAccountName
      Name              = $sqlDatabaseName
    }

    #act
    $result = Confirm-AzBPCosmosDBSqlDatabase @params

    #assert
    $result | Should -BeInLocation $location
  }

  It "Should contain a Cosmos DB SQL Database named $sqlDatabaseName in $rgName" {
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
  Get-Module Az-InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
