BeforeAll {
  Import-Module "../BenchPress/Helpers/BenchPress.Azure/BenchPress.Azure.psd1"
}

Describe 'Verify AKS Cluster Exists' {
  it 'Should contain an AKS cluster named aksbenchpresstest' {
    #arrange
    $resourceGroupName = "rg-test"
    $aksName = "aksbenchpresstest"

    #act
    $exists = Get-AzBPAKSClusterExist -ResourceGroupName $resourceGroupName -AKSName $aksName

    #assert
    $exists | Should -Be $true
  }
}

Describe 'Verify AKS Cluster Does Not Exist' {
  it 'Should not contain an AKS cluster named aksbenchpresstest' {
    #arrange
    $resourceGroupName = "rg-test"
    $aksName = "aksbenchpresstest"

    #act
    # The '-ErrorAction SilentlyContinue' command
    # suppresses errors when the underlying functions
    # don't find the resource; remove this to see the error
    $exists = Get-AzBPAKSClusterExist -ResourceGroupName $resourceGroupName -AKSName $aksName -ErrorAction SilentlyContinue

    #assert
    $exists | Should -Be $false
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
