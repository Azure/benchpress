BeforeAll {
  Import-Module Az.InfrastructureTesting
}

$resourceType = "AksCluster"
$aksName = "aksnqpog"
$rgName = "testrg"

Describe 'Verify AKS Cluster with Confirm-AzBPResource' {
  it 'Should contain an AKS Cluster named aksbenchpresstest' {
    #arrange
    $params = @{
      ResourceType      = $resourceType
      ResourceName      = $aksName
      ResourceGroupName = $rgName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain an AKS Cluster named aksbenchpresstest with agent pool named agentpool' {
    #arrange
    $params = @{
      ResourceType      = $resourceType
      ResourceName      = $aksName
      ResourceGroupName = $rgName
      PropertyKey       = "AgentPoolProfiles[0].Name"
      PropertyValue     = "agentpool"
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }
}

Describe 'Verify AKS Cluster Exists' {
  it 'Should contain an AKS cluster named aksbenchpresstest' {
    #act
    $result = Confirm-AzBPAksCluster -ResourceGroupName $rgName -AKSName $aksName

    #assert
    $result.Success | Should -Be $true
  }
}

Describe 'Verify AKS Cluster Does Not Exist' {
  it 'Should not contain an AKS cluster named aksbenchpresstest' {
    #arrange
    $aksName = 'noakscluster'

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPAksCluster -ResourceGroupName $rgName -AKSName $aksName -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }
}

Describe 'Verify AKS Cluster Exists with Custom Assertion' {
  it 'Should contain an AKS Cluster named aksbenchpresstest' {
    #act
    $result = Confirm-AzBPAksCluster -ResourceGroupName $rgName -AKSName $aksName

    #assert
    $result | Should -BeDeployed
  }
}

Describe 'Verify AKS Cluster Exists in Correct Location' {
  it 'Should contain an AKS Cluster named aksbenchpresstest in westus3' {
    #act
    $result = Confirm-AzBPAksCluster -ResourceGroupName $rgName -AKSName $aksName

    #assert
    $result | Should -BeInLocation 'westus3'
  }
}

Describe 'Verify AKS Cluster Exists in Resource Group' {
  it 'Should be in a resource group named rg-test' {
    #act
    $result = Confirm-AzBPAksCluster -ResourceGroupName $rgName -AKSName $aksName

    #assert
    $result | Should -BeInResourceGroup $rgName
  }
}
