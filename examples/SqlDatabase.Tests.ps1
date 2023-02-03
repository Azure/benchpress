BeforeAll {
    Import-Module "../BenchPress/Helpers/BenchPress.Azure/BenchPress.Azure.psd1"
}

Describe 'Verify Sql Database' {
    it 'Should contain a Sql Database with the given name' {
        #arrange
        $rgName = 'rg-test'
        $serverName = 'azbpsqlserverwithdatabasetest1'
        $databaseName = 'samplesqldatabase'

        #act
        $exists = Get-AzBPSqlDatabase -ResourceGroupName $rgName -DatabaseName $databaseName -ServerName $serverName

        #assert
        $exists | Should -Not -BeNullOrEmpty
    }
}

Describe 'Verify Sql Database Exists' {
    it 'Should contain a Sql Database with the given name' {
        #arrange
        $rgName = 'rg-test'
        $serverName = 'azbpsqlserverwithdatabasetest1'
        $databaseName = 'samplesqldatabase'

        #act
        $exists =  Get-AzBPSqlDatabaseExist -ResourceGroupName $rgName -DatabaseName $databaseName -ServerName $serverName

        #assert
        $exists | Should -Be $true
    }
}

Describe 'Verify Sql Database Exists without providing databaseName flag' {
    it 'Should contain a Sql Database with the given name' {
        #arrange
        $rgName = 'rg-test'
        $serverName = 'azbpsqlserverwithdatabasetest1'

        #act
        $exists =  Get-AzBPSqlDatabaseExist -ResourceGroupName $rgName -ServerName $serverName

        #assert
        $exists | Should -Be $true
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

