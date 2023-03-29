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
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
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
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain an AKS Cluster named $aksName" {
    #act
    $result = Confirm-AzBPAksCluster -ResourceGroupName $rgName -AKSName $aksName

    #assert
    $result.Success | Should -Be $true
  }

  It "Should not contain an AKS Cluster named $noAksClusterName" {
    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPAksCluster -ResourceGroupName $rgName -AKSName $noAksClusterName -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }

  It "Should contain an AKS Cluster named $aksName" {
    #act
    $result = Confirm-AzBPAksCluster -ResourceGroupName $rgName -AKSName $aksName

    #assert
    $result | Should -BeDeployed
  }

  It "Should contain an AKS Cluster named $aksName in $location" {
    #act
    $result = Confirm-AzBPAksCluster -ResourceGroupName $rgName -AKSName $aksName

    #assert
    $result | Should -BeInLocation $location
  }

  It "Should contain an AKS Cluster named $aksName in $rgName" {
    #act
    $result = Confirm-AzBPAksCluster -ResourceGroupName $rgName -AKSName $aksName

    #assert
    $result | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az-InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
