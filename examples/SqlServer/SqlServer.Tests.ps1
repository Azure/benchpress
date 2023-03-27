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
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
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
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should contain a Sql Server with the given name' {
    #act
    $result = Confirm-AzBPSqlServer -ResourceGroupName $rgName -ServerName $serverName

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should not contain a Sql Server with the given name' {
    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPSqlServer -ResourceGroupName $rgName -ServerName $noServerName -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }

  It "Should contain a Sql Server named $serverName" {
    #act
    $result = Confirm-AzBPSqlServer -ResourceGroupName $rgName -ServerName $serverName

    #assert
    $result | Should -BeDeployed
  }

  It "Should contain a Sql Server named $serverName in $location" {
    #act
    $result = Confirm-AzBPSqlServer -ResourceGroupName $rgName -ServerName $serverName

    #assert
    $result | Should -BeInLocation $location
  }

  It "Should be a Sql Server in a resource group named $rgName" {
    #act
    $result = Confirm-AzBPSqlServer -ResourceGroupName $rgName -ServerName $serverName

    #assert
    $result | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az-InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
