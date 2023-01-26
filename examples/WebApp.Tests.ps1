BeforeAll {
    Import-Module "../BenchPress/Helpers/BenchPress.Azure/BenchPress.Azure.psd1"
}

Describe 'Verify Web App' {
    it 'Should contain a Web App with the given name' {
        #arrange
        $rgName = 'rg-test'
        $webappName = 'webapptest1'
        
        #act
        $exists = Get-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webappName

        #assert
        $exists | Should -Not -BeNullOrEmpty
    }
}

Describe 'Verify Web App Exists' {
    it 'Should contain a Web App with the given name' {
        #arrange
        $rgName = 'rg-test'
        $webappName = 'webapptest1'
        
        #act
        $exists = Get-AzBPWebAppExist -ResourceGroupName $rgName -WebAppName $webappName

        #assert
        $exists | Should -Be $true
    }
}

Describe 'Spin up , Tear down a Web App' {
    it 'Should deploy a bicep file.' {
      #arrange
      $resourceGroupName = "rg-test"
      $bicepPath = "./webapp.bicep"
      $params = @{
        hostingPlanName = "webapptest2"
        websiteName     = "websitetest2"
        location        = "westus2"
      }
  
      #act
      $deployment = Deploy-AzBPBicepFeature -BicepPath $bicepPath -Params $params -ResourceGroupName $resourceGroupName
  
      #assert
      $deployment.ProvisioningState | Should -Be "Succeeded"
  
      #clean up
      Remove-AzBPBicepFeature -ResourceGroupName $resourceGroupName
    }
}
