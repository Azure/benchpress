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
  $Script:sqlRoleAssignmentId = "sql-role-assignment-id"
  $Script:sqlRoleDefinitionId = "sql-role-definition-id"
}

Describe 'Verify Cosmos DB Account' {
  It "Should contain a Gremlin Cosmos DB Account named $gremlinAccountName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "CosmosDBAccount"
      ResourceName      = $gremlinAccountName
      ResourceGroupName = $rgName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Gremlin Cosmos DB Account named $gremlinAccountName that is a Global Document DB -
  Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "CosmosDBAccount"
      ResourceName      = $gremlinAccountName
      ResourceGroupName = $rgName
      PropertyKey       = "Kind"
      PropertyValue     = "GlobalDocumentDB"
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Gremlin Cosmos DB named $gremlinDatabaseName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "CosmosDBGremlinDatabase"
      ResourceName      = $gremlinDatabaseName
      ResourceGroupName = $rgName
      AccountName       = $gremlinAccountName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Gremlin Cosmos DB named $gremlinDatabaseName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "CosmosDBGremlinDatabase"
      ResourceName      = $gremlinDatabaseName
      ResourceGroupName = $rgName
      AccountName       = $gremlinAccountName
      PropertyKey       = "Name"
      PropertyValue     = $gremlinDatabaseName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

#######################################################################################################################

  It "Should contain a Mongo Cosmos DB Account named $mongoAccountName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "CosmosDBAccount"
      ResourceName      = $mongoAccountName
      ResourceGroupName = $rgName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Mongo Cosmos DB Account named $mongoAccountName that is a Mongo DB -
  Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "CosmosDBAccount"
      ResourceName      = $mongoAccountName
      ResourceGroupName = $rgName
      PropertyKey       = "Kind"
      PropertyValue     = "MongoDB"
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Mongo Cosmos DB named $mongoDatabaseName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "CosmosDBMongoDBDatabase"
      ResourceName      = $mongoDatabaseName
      ResourceGroupName = $rgName
      AccountName       = $mongoAccountName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Mongo Cosmos DB named $mongoDatabaseName- Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "CosmosDBMongoDBDatabase"
      ResourceName      = $mongoDatabaseName
      ResourceGroupName = $rgName
      AccountName       = $mongoAccountName
      PropertyKey       = "Name"
      PropertyValue     = $mongoDatabaseName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

#######################################################################################################################

  It "Should contain a SQL Cosmos DB Account named $sqlAccountName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "CosmosDBAccount"
      ResourceName      = $sqlAccountName
      ResourceGroupName = $rgName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a SQL Cosmos DB Account named $sqlAccountName that is a Global Document DB -
  Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "CosmosDBAccount"
      ResourceName      = $sqlAccountName
      ResourceGroupName = $rgName
      PropertyKey       = "Kind"
      PropertyValue     = "GlobalDocumentDB"
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a SQL Cosmos DB named $sqlDatabaseName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "CosmosDBSqlDatabase"
      ResourceName      = $sqlDatabaseName
      ResourceGroupName = $rgName
      AccountName       = $sqlAccountName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a SQL Cosmos DB named $sqlDatabaseName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "CosmosDBSqlDatabase"
      ResourceName      = $sqlDatabaseName
      ResourceGroupName = $rgName
      AccountName       = $sqlAccountName
      PropertyKey       = "Name"
      PropertyValue     = $sqlDatabaseName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Cosmos DB SQL Role Assignment named $sqlRoleAssignmentId - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "CosmosDBSqlRoleAssignment"
      ResourceGroupName = $rgName
      AccountName       = $sqlAccountName
      RoleAssignmentId  = $sqlRoleAssignmentId
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Cosmos DB SQL Role Assignment named $sqlRoleAssignmentId - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "CosmosDBSqlRoleAssignment"
      ResourceGroupName = $rgName
      AccountName       = $sqlAccountName
      RoleAssignmentId  = $sqlRoleAssignmentId
      PropertyKey       = "Id"
      PropertyValue     = $sqlRoleAssignmentId
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Cosmos DB SQL Role Definition named $sqlRoleDefinitionId - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "CosmosDBSqlRoleDefinition"
      ResourceGroupName = $rgName
      AccountName       = $sqlAccountName
      RoleDefinitionId  = $sqlRoleDefinitionId
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Cosmos DB SQL Role Definition named $sqlRoleDefinitionId - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "CosmosDBSqlRoleDefinition"
      ResourceGroupName = $rgName
      AccountName       = $sqlAccountName
      RoleDefinitionId  = $sqlRoleDefinitionId
      PropertyKey       = "Id"
      PropertyValue     = $sqlRoleDefinitionId
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
    # arrange
    # The 'ErrorAction = SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      Name              = $noGremlinDBAccountName
      ErrorAction       = "SilentlyContinue"
    }

    # act and assert
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
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $gremlinAccountName
      Name              = $gremlinDatabaseName
    }

    # act and assert
    Confirm-AzBPCosmosDBGremlinDatabase @params | Should -BeSuccessful
  }

  It "Should not contain a Cosmos DB Gremlin Database named $noGremlinDBName" {
    # The 'ErrorAction = SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $gremlinAccountName
      Name              = $noGremlinDBName
      ErrorAction       = "SilentlyContinue"
    }

    # act and assert
    Confirm-AzBPCosmosDBGremlinDatabase @params | Should -Not -BeSuccessful
  }

  It "Should contain a Cosmos DB Gremlin Database named $gremlinDatabaseName in $rgName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $gremlinAccountName
      Name              = $gremlinDatabaseName
    }

    # act and assert
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
    # arrange
    # The 'ErrorAction = SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      Name              = $noMongoDBAccountName
      ErrorAction       = "SilentlyContinue"
    }

    # act and assert
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
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $mongoAccountName
      Name              = $mongoDatabaseName
    }

    # act and assert
    Confirm-AzBPCosmosDBMongoDBDatabase @params | Should -BeSuccessful
  }

  It "Should not contain a Cosmos DB Mongo DB Database named $noMongoDBName" {
    # arrange
    # The 'ErrorAction = SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $mongoAccountName
      Name              = $noMongoDBName
      ErrorAction       = "SilentlyContinue"
    }

    # act and assert
    Confirm-AzBPCosmosDBMongoDBDatabase @params | Should -Not -BeSuccessful
  }

  It "Should contain a Cosmos DB Mongo DB Database named $mongoDatabaseName in $rgName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $mongoAccountName
      Name              = $mongoDatabaseName
    }

    # act and assert
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
    # arrange
    # The 'ErrorAction = SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      Name              = $noSqlAccountName
      ErrorAction       = "SilentlyContinue"
    }

    # act and assert
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
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $sqlAccountName
      Name              = $sqlDatabaseName
    }

    # act and assert
    Confirm-AzBPCosmosDBSqlDatabase @params | Should -BeSuccessful
  }

  It "Should not contain a Cosmos DB SQL Database named $noSqlDatabaseName" {
    # arrange
    # The 'ErrorAction = SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $sqlAccountName
      Name              = $noSqlDatabaseName
      ErrorAction       = "SilentlyContinue"
    }

    # act and assert
    Confirm-AzBPCosmosDBSqlDatabase @params | Should -Not -BeSuccessful
  }

  It "Should contain a Cosmos DB SQL Database named $sqlDatabaseName in $rgName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $sqlAccountName
      Name              = $sqlDatabaseName
    }

    # act and assert
    Confirm-AzBPCosmosDBSqlDatabase @params | Should -BeInResourceGroup $rgName
  }
}

Describe 'Comsos DB SQL Role Assignment' {
  BeforeAll {
    $Script:noSqlRoleAssignmentId = 'nosqlroleassignmentbptest'
  }

  It "Should contain a Cosmos DB SQL Role assignment named $sqlRoleAssignmentId" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $sqlAccountName
      RoleAssignmentId  = $sqlRoleAssignmentId
    }

    # act and assert
    Confirm-AzBPCosmosDBSqlRoleAssignment @params | Should -BeSuccessful
  }

  It "Should not contain a Cosmos DB SQL Role assignment named $noSqlRoleAssignmentId" {
    # arrange
    # The 'ErrorAction = SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $sqlAccountName
      RoleAssignmentId  = $noSqlRoleAssignmentId
      ErrorAction       = "SilentlyContinue"
    }

    # act and assert
    Confirm-AzBPCosmosDBSqlRoleAssignment @params | Should -Not -BeSuccessful
  }

  It "Should contain a Cosmos DB SQL Role assignment named $sqlRoleAssignmentId in $rgName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $sqlAccountName
      RoleAssignmentId  = $sqlRoleAssignmentId
    }

    # act and assert
    Confirm-AzBPCosmosDBSqlRoleAssignment @params | Should -BeInResourceGroup $rgName
  }
}

Describe 'Comsos DB SQL Role Definition' {
  BeforeAll {
    $Script:noSqlRoleDefinitionId = 'nosqlroledefinitionbptest'
  }

  It "Should contain a Cosmos DB SQL Role definition named $sqlRoleDefinitionId" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $sqlAccountName
      RoleDefinitionId  = $sqlRoleDefinitionId
    }

    # act and assert
    Confirm-AzBPCosmosDBSqlRoleDefinition @params | Should -BeSuccessful
  }

  It "Should not contain a Cosmos DB SQL Role definition named $noSqlRoleDefinitionId" {
    # arrange
    # The 'ErrorAction = SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $sqlAccountName
      RoleDefinitionId  = $noSqlRoleDefinitionId
      ErrorAction       = "SilentlyContinue"
    }

    # act and assert
    Confirm-AzBPCosmosDBSqlRoleDefinition @params | Should -Not -BeSuccessful
  }

  It "Should contain a Cosmos DB SQL Role definition named $sqlRoleDefinitionId in $rgName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      AccountName       = $sqlAccountName
      RoleDefinitionId  = $sqlRoleDefinitionId
    }

    # act and assert
    Confirm-AzBPCosmosDBSqlRoleDefinition @params | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
