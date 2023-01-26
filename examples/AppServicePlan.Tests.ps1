BeforeAll {
    Import-Module "../BenchPress/Helpers/BenchPress.Azure/BenchPress.Azure.psd1"
}

Describe 'Verify App Service Plan' {
    it 'Should contain an App Service Plan with the given name' {
        #arrange
        $rgName = 'rg-test'
        $appServicePlanName = 'appserviceplantest1'
        
        #act
        $exists = Get-AzBPAppServicePlan -ResourceGroupName $rgName -Name $appServicePlanName

        #assert
        $exists | Should -Not -BeNullOrEmpty
    }
}

Describe 'Verify App Service Plan Exists' {
    it 'Should contain an App Service Plan with the given name' {
        #arrange
        $rgName = 'rg-test'
        $appServicePlanName = 'appserviceplantest1'
        
        #act
        $exists = Get-AzBPAppServicePlanExist -ResourceGroupName $rgName -Name $appServicePlanName

        #assert
        $exists | Should -Be $true
    }
}

Describe 'Spin up , Tear down App Service Plan' {
    it 'Should deploy a bicep file.' {
      #arrange
      $resourceGroupName = "rg-test"
      $bicepPath = "./appserviceplan.bicep"
      $params = @{
        name           = "appserviceplantest2"
        location       = "westus2"
      }
  
      #act
      $deployment = Deploy-AzBPBicepFeature -BicepPath $bicepPath -Params $params -ResourceGroupName $resourceGroupName
  
      #assert
      $deployment.ProvisioningState | Should -Be "Succeeded"
  
      #clean up
      Remove-AzBPBicepFeature -ResourceGroupName $resourceGroupName
    }
}