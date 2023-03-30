BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:location = 'westus3'
  $Script:serverName = 'samplesqlserver'
  $Script:databaseName = 'samplesqldatabase'
}

Describe 'Verify Sql Database' {
  BeforeAll {
    $Script:noDatabaseName = 'nosamplesqlserver'
  }

  It 'Should contain a sql database with given name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType      = "SqlDatabase"
      ResourceName      = $databaseName
      ResourceGroupName = $rgName
      ServerName        = $serverName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }


  It 'Should contain a sql database with expected property name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType      = "SqlDatabase"
      ResourceName      = $databaseName
      ResourceGroupName = $rgName
      ServerName        = $serverName
      PropertyKey       = 'DatabaseName'
      PropertyValue     = $databaseName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Sql Database named $databaseName" {
    $params = @{
      ResourceGroupName = $rgName
      DatabaseName = $databaseName
      ServerName = $serverName
    }

    Confirm-AzBPSqlDatabase @params | Should -BeSuccessful
  }

  It 'Should not contain a Sql Database with the given name' {
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      DatabaseName = $noDatabaseName
      ServerName = $serverName
    }

    Confirm-AzBPSqlDatabase @params -ErrorAction SilentlyContinue | Should -Not -BeSuccessful
  }

  It "Should contain a Sql Database named $databaseName in $location" {
    $params = @{
      ResourceGroupName = $rgName
      DatabaseName = $databaseName
      ServerName = $serverName
    }

    Confirm-AzBPSqlDatabase @params | Should -BeInLocation $location
  }

  It "Should be a Sql Database in a resource group named $rgName" {
    $params = @{
      ResourceGroupName = $rgName
      DatabaseName = $databaseName
      ServerName = $serverName
    }

    Confirm-AzBPSqlDatabase @params | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
