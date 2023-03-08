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
