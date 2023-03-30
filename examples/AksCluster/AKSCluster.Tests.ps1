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

  It "Should contain an AKS Cluster named $aksName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "AksCluster"
      ResourceName      = $aksName
      ResourceGroupName = $rgName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an AKS Cluster named $aksName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "AksCluster"
      ResourceName      = $aksName
      ResourceGroupName = $rgName
      PropertyKey       = "AgentPoolProfiles[0].Name"
      PropertyValue     = "agentpool"
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an AKS Cluster named $aksName" {
    Confirm-AzBPAksCluster -ResourceGroupName $rgName -AKSName $aksName | Should -BeSuccessful
  }

  It 'Should not contain an AKS cluster with given name' {
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    Confirm-AzBPAksCluster -ResourceGroupName $rgName -AKSName $noAksClusterName -ErrorAction SilentlyContinue | Should -Not -BeSuccessful
  }
  It "Should contain an AKS Cluster named $aksName in $location" {
    Confirm-AzBPAksCluster -ResourceGroupName $rgName -AKSName $aksName | Should -BeInLocation $location
  }

  It "Should be an AKS CLuster named $aksName in a resource group named $rgName" {
    Confirm-AzBPAksCluster -ResourceGroupName $rgName -AKSName $aksName | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
