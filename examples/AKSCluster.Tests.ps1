BeforeAll {
  Import-Module "../BenchPress/Helpers/BenchPress.Azure/BenchPress.Azure.psd1"
}

Describe 'Verify AKS Cluster Exists' {
  it 'Should contain a resource group named rgbenchpresstest' {
    #arrange
    $resourceGroupName = "rg-test"
    $aksName = "aksbenchpresstest"

    #act
    $result = Confirm-AzBPAksCluster -ResourceGroupName $resourceGroupName -AKSName $aksName

    #assert
    $result.Success | Should -Be $true
  }
}

Describe 'Spin up , Tear down AKS Cluster' {
  it 'Should deploy a bicep file.' {
    #arrange
    $resourceGroupName = "rg-test"
    $bicepPath = "./aksCluster.bicep"
    $params = @{
      name        = "aksbenchpresstest"
      location    = "westus"
    }

    #act
    $deployment = Deploy-AzBPBicepFeature -BicepPath $bicepPath -Params $params -ResourceGroupName $resourceGroupName

    #assert
    $deployment.ProvisioningState | Should -Be "Succeeded"

    #clean up
    Remove-AzBPBicepFeature -ResourceGroupName $resourceGroupName
  }
}
