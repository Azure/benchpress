BeforeAll {
    Import-Module "../BenchPress/Helpers/BenchPress.Azure/BenchPress.Azure.psd1"
}

Describe 'Verify Sql Database Exists' {
    it 'Should contain a Sql Database with the given name' {
        #arrange
        $rgName = 'rg-test'
        $serverName = 'azbpsqlserverwithdatabasetest1'
        $databaseName = 'samplesqldatabase'

        #act
        $result =  Confirm-AzBPSqlDatabase -ResourceGroupName $rgName -DatabaseName $databaseName -ServerName $serverName

        #assert
        $result.Success | Should -Be $true
    }
}

Describe 'Verify Sql Database Exists without providing databaseName flag' {
    it 'Should contain a Sql Database with the given name' {
        #arrange
        $rgName = 'rg-test'
        $serverName = 'azbpsqlserverwithdatabasetest1'

        #act
        $result =  Confirm-AzBPSqlDatabase -ResourceGroupName $rgName -ServerName $serverName

        #assert
        $result.Success | Should -Be $true
    }
}

Describe 'Verify Sql Database Does Not Exist' {
    it 'Should not contain a Sql Database with the given name' {
        #arrange
        $rgName = 'rg-test'
        $serverName = 'azbpsqlserverwithdatabasetest1'
        $databaseName = 'samplesqldatabase'

        #act
        # The '-ErrorAction SilentlyContinue' command suppresses all errors.
        # In this test, it will suppress the error message when a resource cannot be found.
        # Remove this field to see all errors.
        $result =  Confirm-AzBPSqlDatabase -ResourceGroupName $rgName -DatabaseName $databaseName -ServerName $serverName -ErrorAction SilentlyContinue

        #assert
        $result.Success | Should -Be $false
    }
}

Describe 'Spin up , Tear down Sql Database' {
    it 'Should deploy a bicep file.' {
      #arrange
      $resourceGroupName = "rg-test"
      $bicepPath = "./sqldatabase.bicep"
      $params = @{
        databaseName   = "sqldatabasetest2"
        serverName     = "azbpsqlserverwithdatabasetest2"
        location       = "westus3"
      }

      #act
      $deployment = Deploy-AzBPBicepFeature -BicepPath $bicepPath -Params $params -ResourceGroupName $resourceGroupName

      #assert
      $deployment.ProvisioningState | Should -Be "Succeeded"

      #clean up
      Remove-AzBPBicepFeature -ResourceGroupName $resourceGroupName
    }
}
