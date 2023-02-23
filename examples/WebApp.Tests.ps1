BeforeAll {
    Import-Module "../BenchPress/Helpers/BenchPress.Azure/BenchPress.Azure.psd1"
}

Describe 'Verify Web App Exists' {
    it 'Should contain a Web App with the given name' {
        #arrange
        $rgName = 'rg-test'
        $webappName = 'azbpwebapptest1'

        #act
        $result = Confirm-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webappName

        #assert
        $result.Success | Should -Be $true
    }
}

Describe 'Verify Web App Does Not Exist' {
    it 'Should not contain a Web App with the given name' {
        #arrange
        $rgName = 'rg-test'
        $webappName = 'azbpwebapptest1'

        #act
        # The '-ErrorAction SilentlyContinue' command suppresses all errors.
        # In this test, it will suppress the error message when a resource cannot be found.
        # Remove this field to see all errors.
        $result = Confirm-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webappName -ErrorAction SilentlyContinue

        #assert
        $result.Success | Should -Be $false
    }
}

Describe 'Spin up , Tear down a Web App' {
    it 'Should deploy a bicep file.' {
      #arrange
      $resourceGroupName = "rg-test"
      $bicepPath = "./webapp.bicep"
      $params = @{
        appserviceplanName = "appservicetest2"
        webappName     = "azbpwebapptest2"
        location        = "westus3"
      }

      #act
      $deployment = Deploy-AzBPBicepFeature -BicepPath $bicepPath -Params $params -ResourceGroupName $resourceGroupName

      #assert
      $deployment.ProvisioningState | Should -Be "Succeeded"

      #clean up
      Remove-AzBPBicepFeature -ResourceGroupName $resourceGroupName
    }
}
