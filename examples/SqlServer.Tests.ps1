BeforeAll {
    Import-Module "../BenchPress/Helpers/BenchPress.Azure/BenchPress.Azure.psd1"
}

Describe 'Verify Sql Server Exists' {
    it 'Should contain a Sql Server with the given name' {
        #arrange
        $rgName = 'rg-test'
        $serverName = 'azbenchpreesssqlservertest1'

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
        $serverName = 'azbenchpreesssqlservertest1'

        #act
        # The '-ErrorAction SilentlyContinue' command suppresses all errors.
        # In this test, it will suppress the error message when a resource cannot be found.
        # Remove this field to see all errors.
        $result = Confirm-AzBPSqlServer -ResourceGroupName $rgName -ServerName $serverName -ErrorAction SilentlyContinue

        #assert
        $result.Success | Should -Be $false
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
