BeforeAll {
  Import-Module "../BenchPress/Helpers/Azure/AKSCluster.psm1"
  Import-Module "../BenchPress/Helpers/Azure/Bicep.psm1"
}

Describe 'Verify AKS Cluster Exists' {
  it 'Should contain a resource group named rgbenchpresstest' {
    #arrange
    $aksName = "aksbenchpresstest"
    $rgName = "rgbenchpresstest"

    #act
    $exists = Get-AKSClusterExist -resourceGroupName $rgName -aksName $aksName

    #assert
    $exists | Should -Be $true
  }
}

Describe 'Spin up , Tear down AKS Cluster' {
  it 'Should deploy a bicep file.' {
    #arrange
    $bicepPath = "./aksCluster.bicep"
    $params = @{
      name        = "aksbenchpresstest"
      location    = "westus"
    }
    #act
    $deployment = Deploy-BicepFeature $bicepPath $params "rgbenchpresstest"
    #assert
    $deployment.ProvisioningState | Should -Be "Succeeded"

    #clean up
    Remove-BicepFeature "rgbenchpresstest"
  }
}
