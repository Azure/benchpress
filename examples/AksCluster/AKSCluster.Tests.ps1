BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:aksName = 'aksbenchpresstest'
  $Script:location = 'westus3'
}

Describe 'Verify AKS Cluster' {
  BeforeAll {
    $Script:noAksClusterName = 'noakscluster'
  }

  it 'Should contain an AKS Cluster - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType      = "AksCluster"
      ResourceName      = $aksName
      ResourceGroupName = $rgName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain an AKS Cluster - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType      = "AksCluster"
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

  it 'Should contain an AKS cluster with given name' {
    #act
    $result = Confirm-AzBPAksCluster -ResourceGroupName $rgName -AKSName $aksName

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should not contain an AKS cluster with given name' {
    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPAksCluster -ResourceGroupName $rgName -AKSName 'no' -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }

  it "Should contain an AKS Cluster named $aksName" {
    #act
    $result = Confirm-AzBPAksCluster -ResourceGroupName $rgName -AKSName $aksName

    #assert
    $result | Should -BeDeployed
  }

  it "Should contain an AKS Cluster named $aksName in $location" {
    #act
    $result = Confirm-AzBPAksCluster -ResourceGroupName $rgName -AKSName $aksName

    #assert
    $result | Should -BeInLocation $location
  }

  it "Should be an AKS CLuster named $aksName in a resource group named $rgName" {
    #act
    $result = Confirm-AzBPAksCluster -ResourceGroupName $rgName -AKSName $aksName

    #assert
    $result | Should -BeInResourceGroup $rgName
  }
}
