BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:location = 'westus3'
  $Script:serverName = 'samplesqlserver'
}

Describe 'Verify Sql Server' {
  BeforeAll {
    $Script:noServerName = 'nosamplesqlserver'
  }

  It 'Should contain a sql server with given name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType      = "SqlServer"
      ResourceName      = $serverName
      ResourceGroupName = $rgName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }


  It 'Should contain a sql server with expected property name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType      = "SqlServer"
      ResourceName      = $serverName
      ResourceGroupName = $rgName
      PropertyKey       = 'ServerName'
      PropertyValue     = $serverName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Sql Server named $serverName" {
    Confirm-AzBPSqlServer -ResourceGroupName $rgName -ServerName $serverName | Should -BeSuccessful
  }

  It 'Should not contain a Sql Server with the given name' {
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    Confirm-AzBPSqlServer -ResourceGroupName $rgName -ServerName $noServerName -ErrorAction SilentlyContinue | Should -Not -BeSuccessful
  }

  It "Should contain a Sql Server named $serverName in $location" {
    Confirm-AzBPSqlServer -ResourceGroupName $rgName -ServerName $serverName | Should -BeInLocation $location
  }

  It "Should be a Sql Server in a resource group named $rgName" {
    Confirm-AzBPSqlServer -ResourceGroupName $rgName -ServerName $serverName | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
