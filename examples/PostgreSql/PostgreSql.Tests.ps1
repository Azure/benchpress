BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName       = 'rg-test'
  $Script:location     = 'westus3'
  $Script:serverName   = 'samplepostgresqlserver'
  $Script:noServerName = 'nosamplepostgresqlserver'
}

Describe 'Verify PostgreSql Flexible Server' {
  It "Should contain a PostgreSQL Flexible Server named $serverName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "PostgreSqlFlexibleServer"
      ResourceName      = $serverName
      ResourceGroupName = $rgName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a PostgreSQL Flexible Server with Name property of $serverName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "PostgreSqlFlexibleServer"
      ResourceName      = $serverName
      ResourceGroupName = $rgName
      PropertyKey       = 'Name'
      PropertyValue     = $serverName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a PostgreSQL Flexible Server named $serverName" {
    Confirm-AzBPPostgreSqlFlexibleServer -ResourceGroupName $rgName -Name $serverName | Should -BeSuccessful
  }

  It "Should contain a PostgreSQL Flexible Server named $serverName in $location" {
    Confirm-AzBPPostgreSqlFlexibleServer -ResourceGroupName $rgName -Name $serverName | Should -BeInLocation $location
  }

  It "Should contain a PostgreSQL Flexible Server named $serverName in a resource group named $rgName" {
    Confirm-AzBPPostgreSqlFlexibleServer -ResourceGroupName $rgName -Name $serverName
    | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
