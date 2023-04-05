﻿BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:location = 'westus3'
  $Script:serverName = 'samplesqlserver'
  $Script:noDatabaseName = 'nosamplesqlserver'
  $Script:databaseName = 'samplesqldatabase'
}

Describe 'Verify SQL Database' {
  It "Should contain a SQL Database named $databaseName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "SqlDatabase"
      ResourceName      = $databaseName
      ResourceGroupName = $rgName
      ServerName        = $serverName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }


  It "Should contain a SQL Database named $databaseName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "SqlDatabase"
      ResourceName      = $databaseName
      ResourceGroupName = $rgName
      ServerName        = $serverName
      PropertyKey       = 'DatabaseName'
      PropertyValue     = $databaseName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a SQL Database named $databaseName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      DatabaseName      = $databaseName
      ServerName        = $serverName
    }

    # act and assert
    Confirm-AzBPSqlDatabase @params | Should -BeSuccessful
  }

  It "Should not contain a SQL Database named $noDatabaseName" {
    # arrange
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      DatabaseName      = $noDatabaseName
      ServerName        = $serverName
      ErrorAction       = "SilentlyContinue"
    }

    # act and asssert
    Confirm-AzBPSqlDatabase @params | Should -Not -BeSuccessful
  }

  It "Should contain a SQL Database named $databaseName in $location" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      DatabaseName      = $databaseName
      ServerName        = $serverName
    }

    # act and assert
    Confirm-AzBPSqlDatabase @params | Should -BeInLocation $location
  }

  It "Should contain a SQL Database named $databaseName in $rgName" {
    # arrange
    $params = @{
      ResourceGroupName = $rgName
      DatabaseName      = $databaseName
      ServerName        = $serverName
    }

    # act and assert
    Confirm-AzBPSqlDatabase @params | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
