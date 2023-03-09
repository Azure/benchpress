BeforeAll {
  Import-Module Az-InfrastructureTest
}

Describe 'Verify AKS Cluster Exists' {
  it 'Should contain an AKS cluster named aksbenchpresstest' {
    #arrange
    $resourceGroupName = "rg-test"
    $aksName = "aksbenchpresstest"

    #act
    $result = Confirm-AzBPAksCluster -ResourceGroupName $resourceGroupName -AKSName $aksName

    #assert
    $result.Success | Should -Be $true
  }
}

Describe 'Verify AKS Cluster Does Not Exist' {
  it 'Should not contain an AKS cluster named aksbenchpresstest' {
    #arrange
    $resourceGroupName = "rg-test"
    $aksName = "noaksbenchpresstest"

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPAksCluster -ResourceGroupName $resourceGroupName -AKSName $aksName -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }
}

Describe 'Verify AKS Cluster Exists with Custom Assertion' {
  it 'Should contain an AKS Cluster named aksbenchpresstest' {
    #arrange
    $resourceGroupName = "rg-test"
    $aksName = "aksbenchpresstest"

    #act
    $result = Confirm-AzBPAksCluster -ResourceGroupName $resourceGroupName -AKSName $aksName

    #assert
    $result | Should -BeDeployed
  }
}

Describe 'Verify AKS Cluster Exists in Correct Location' {
  it 'Should contain an AKS Cluster named aksbenchpresstest in westus3' {
    #arrange
    $resourceGroupName = "rg-test"
    $aksName = "aksbenchpresstest"

    #act
    $result = Confirm-AzBPAksCluster -ResourceGroupName $resourceGroupName -AKSName $aksName

    #assert
    $result | Should -BeInLocation 'westus3'
  }
}

Describe 'Verify AKS Cluster Exists in Resource Group' {
  it 'Should be in a resource group named rg-test' {
    #arrange
    $resourceGroupName = "rg-test"
    $aksName = "aksbenchpresstest"

    #act
    $result = Confirm-AzBPAksCluster -ResourceGroupName $resourceGroupName -AKSName $aksName

    #assert
    $result | Should -BeInResourceGroup 'rg-test'
  }
}
