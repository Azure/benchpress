BeforeAll {
    Import-Module "../BenchPress/Helpers/BenchPress.Azure/BenchPress.Azure.psd1"
}

Describe 'Verify Sql Server' {
    it 'Should contain a Sql Server with the given name' {
        #arrange
        $rgName = 'rg-test'
        $serverName = 'azbenchpreesssqlservertest1'

        #act
        $exists = Get-AzBPSqlServer -ResourceGroupName $rgName -ServerName $serverName

        #assert
        $exists | Should -Not -BeNullOrEmpty
    }
}

Describe 'Verify Sql Server Exists' {
    it 'Should contain a Sql Server with the given name' {
        #arrange
        $rgName = 'rg-test'
        $serverName = 'azbenchpreesssqlservertest1'

        #act
        $exists = Get-AzBPSqlServerExist -ResourceGroupName $rgName -ServerName $serverName

        #assert
        $exists | Should -Be $true
    }
}

Describe 'Spin up , Tear down a Sql Server' {
    it 'Should deploy a bicep file.' {
      #arrange
      $resourceGroupName = "rg-test"
      $bicepPath = "./sqlserver.bicep"
      $params = @{
        name           = "azbenchpreesssqlservertest2"
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
