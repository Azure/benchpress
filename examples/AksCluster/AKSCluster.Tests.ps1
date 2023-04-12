BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName   = 'rg-test'
  $Script:aksName  = 'aksbenchpresstest'
  $Script:location = 'westus3'
}

Describe 'Verify AKS Cluster' {
  BeforeAll {
    $Script:noAksClusterName = 'noakscluster'
  }

  It "Should contain an AKS Cluster named $aksName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "AksCluster"
      ResourceName      = $aksName
      ResourceGroupName = $rgName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an AKS Cluster named $aksName with an Agent Pool Profile named agentpool - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "AksCluster"
      ResourceName      = $aksName
      ResourceGroupName = $rgName
      PropertyKey       = "AgentPoolProfiles[0].Name"
      PropertyValue     = "agentpool"
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an AKS Cluster named $aksName" {
    Confirm-AzBPAksCluster -ResourceGroupName $rgName -AKSName $aksName | Should -BeSuccessful
  }

  It "Should not contain an AKS Cluster named $noAksClusterName" {
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    Confirm-AzBPAksCluster -ResourceGroupName $rgName -AKSName $noAksClusterName -ErrorAction SilentlyContinue
    | Should -Not -BeSuccessful
  }
  It "Should contain an AKS Cluster named $aksName in $location" {
    Confirm-AzBPAksCluster -ResourceGroupName $rgName -AKSName $aksName | Should -BeInLocation $location
  }

  It "Should contain an AKS Cluster named $aksName in $rgName" {
    Confirm-AzBPAksCluster -ResourceGroupName $rgName -AKSName $aksName | Should -BeInResourceGroup $rgName
  }
}

Describe 'Verify AKS Node Pool' {
  BeforeAll {
    $Script:nodePoolName   = 'nodepoolbenchpresstest'
    $Script:noNodePoolName = 'noaksnodepool'
  }

  It "Should contain an AKS Node Pool named $nodePoolName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "AksNodePool"
      ResourceGroupName = $rgName
      ClusterName       = $aksName
      ResourceName      = $nodePoolName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an AKS NodePool named $nodePoolName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "AksNodePool"
      ResourceGroupName = $rgName
      ClusterName       = $aksName
      ResourceName      = $nodePoolName
      PropertyKey       = "Name"
      PropertyValue     = $nodePoolName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an AKS Node Pool named $nodePoolName" {
    Confirm-AzBPAksNodePool -ResourceGroupName $rgName -ClusterName $aksName -Name $nodePoolName | Should -BeSuccessful
  }

  It "Should not contain an AKS Node Pool named $noNodePoolName" {
    # arrange
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      ClusterName       = $aksName
      Name              = $noNodePoolName
      ErrorAction       = "SilentlyContinue"
    }

    # act and assert
    Confirm-AzBPAksNodePool @params | Should -Not -BeSuccessful
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
