BeforeAll {
  Import-Module Az.InfrastructureTesting
}

Describe 'Verify Sql Server Exists' {
  it 'Should contain a Sql Server with the given name' {
    #arrange
    $rgName = 'rg-test'
    $serverName = 'samplesqlserver'

    #act
    $result = Confirm-AzBPSqlServer -ResourceGroupName $rgName -ServerName $serverName

    #assert
    $result.Success | Should -Be $true
  }
}

Describe 'Verify Sql Server Does Not Exist' {
  it 'Should not contain a Sql Server with the given name' {
    #arrange
    $rgName = 'rg-test'
    $serverName = 'nosamplesqlserver'

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPSqlServer -ResourceGroupName $rgName -ServerName $serverName -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }
}

Describe 'Verify Sql Server Exists with Custom Assertion' {
  it 'Should contain a Sql Server named samplesqlserver' {
    #arrange
    $rgName = 'rg-test'
    $serverName = 'samplesqlserver'

    #act
    $result = Confirm-AzBPSqlServer -ResourceGroupName $rgName -ServerName $serverName

    #assert
    $result | Should -BeDeployed
  }
}

Describe 'Verify Sql Server Exists in Correct Location' {
  it 'Should contain a Sql Server named samplesqlserver in westus3' {
    #arrange
    $rgName = 'rg-test'
    $serverName = 'samplesqlserver'

    #act
    $result = Confirm-AzBPSqlServer -ResourceGroupName $rgName -ServerName $serverName

    #assert
    $result | Should -BeInLocation 'westus3'
  }
}

Describe 'Verify Sql Server Exists in Resource Group' {
  it 'Should be a Sql Server in a resource group named rg-test' {
    #arrange
    $rgName = 'rg-test'
    $serverName = 'samplesqlserver'

    #act
    $result = Confirm-AzBPSqlServer -ResourceGroupName $rgName -ServerName $serverName

    #assert
    $result | Should -BeInResourceGroup 'rg-test'
  }
}
