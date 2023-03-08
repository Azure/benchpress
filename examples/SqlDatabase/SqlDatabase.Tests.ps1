BeforeAll {
  Import-Module Az-InfrastructureTest
}

Describe 'Verify Sql Database Exists' {
  it 'Should contain a Sql Database with the given name' {
    #arrange
    $rgName = 'rg-test'
    $serverName = 'samplesqlserver'
    $databaseName = 'samplesqldatabase'

    #act
    $result =  Confirm-AzBPSqlDatabase -ResourceGroupName $rgName -DatabaseName $databaseName -ServerName $serverName

    #assert
    $result.Success | Should -Be $true
  }
}

Describe 'Verify Sql Database Does Not Exist' {
  it 'Should not contain a Sql Database with the given name' {
    #arrange
    $rgName = 'rg-test'
    $serverName = 'samplesqlserver'
    $databaseName = 'nosamplesqldatabase'

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result =  Confirm-AzBPSqlDatabase -ResourceGroupName $rgName -DatabaseName $databaseName -ServerName $serverName -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }
}

Describe 'Verify Sql Database Exists with Custom Assertion' {
  it 'Should contain a Sql Database named samplesqldatabase' {
    #arrange
    $rgName = 'rg-test'
    $serverName = 'samplesqlserver'
    $databaseName = 'samplesqldatabase'

    #act
    $result =  Confirm-AzBPSqlDatabase -ResourceGroupName $rgName -DatabaseName $databaseName -ServerName $serverName

    #assert
    $result | Should -BeDeployed
  }
}
  
Describe 'Verify Sql Database Exists in Correct Location' {
  it 'Should contain a Sql Database named samplesqldatabase in westus3' {
    #arrange
    $rgName = 'rg-test'
    $serverName = 'samplesqlserver'
    $databaseName = 'samplesqldatabase'

    #act
    $result =  Confirm-AzBPSqlDatabase -ResourceGroupName $rgName -DatabaseName $databaseName -ServerName $serverName

    #assert
    $result | Should -BeInLocation 'westus3'
  }
}
  
Describe 'Verify Sql Database Exists in Resource Group' {
  it 'Should be a Sql Database in a resource group named rg-test' {
    #arrange
    $rgName = 'rg-test'
    $serverName = 'samplesqlserver'
    $databaseName = 'samplesqldatabase'

    #act
    $result =  Confirm-AzBPSqlDatabase -ResourceGroupName $rgName -DatabaseName $databaseName -ServerName $serverName

    #assert
    $result | Should -BeInResourceGroup 'rg-test'
  }
}
