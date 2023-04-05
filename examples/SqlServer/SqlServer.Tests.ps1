BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:location = 'westus3'
  $Script:serverName = 'samplesqlserver'
  $Script:noServerName = 'nosamplesqlserver'
}

Describe 'Verify SQL Server' {
  It "Should contain a SQL Server named $serverName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "SqlServer"
      ResourceName      = $serverName
      ResourceGroupName = $rgName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }


  It "Should contain a SQL Server named $serverName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "SqlServer"
      ResourceName      = $serverName
      ResourceGroupName = $rgName
      PropertyKey       = 'ServerName'
      PropertyValue     = $serverName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a SQL Server named $serverName" {
    Confirm-AzBPSqlServer -ResourceGroupName $rgName -ServerName $serverName | Should -BeSuccessful
  }

  It "Should not contain a SQL Server named $noServerName" {
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    Confirm-AzBPSqlServer -ResourceGroupName $rgName -ServerName $noServerName -ErrorAction SilentlyContinue
    | Should -Not -BeSuccessful
  }

  It "Should contain a SQL Server named $serverName in $location" {
    Confirm-AzBPSqlServer -ResourceGroupName $rgName -ServerName $serverName | Should -BeInLocation $location
  }

  It "Should contain a SQL Server named $serverName in $rgName" {
    Confirm-AzBPSqlServer -ResourceGroupName $rgName -ServerName $serverName | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
