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
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
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
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should contain a Sql Database with the given name' {
    #act
    $result =  Confirm-AzBPSqlDatabase -ResourceGroupName $rgName -DatabaseName $databaseName -ServerName $serverName

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should not contain a Sql Database with the given name' {
    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result =  Confirm-AzBPSqlDatabase -ResourceGroupName $rgName -DatabaseName $noDatabaseName -ServerName $serverName -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }

  It "Should contain a Sql Database named $databaseName" {
    #act
    $result =  Confirm-AzBPSqlDatabase -ResourceGroupName $rgName -DatabaseName $databaseName -ServerName $serverName

    #assert
    $result | Should -BeDeployed
  }

  It "Should contain a Sql Database named $databaseName in $location" {
    #act
    $result =  Confirm-AzBPSqlDatabase -ResourceGroupName $rgName -DatabaseName $databaseName -ServerName $serverName

    #assert
    $result | Should -BeInLocation $location
  }

  It "Should be a Sql Database in a resource group named $rgName" {
    #act
    $result =  Confirm-AzBPSqlDatabase -ResourceGroupName $rgName -DatabaseName $databaseName -ServerName $serverName

    #assert
    $result | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
