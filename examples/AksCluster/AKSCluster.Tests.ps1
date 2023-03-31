BeforeAll {
  Import-Module ../../bin/BenchPress.Azure.psd1

  $Script:rgName = 'marc-benchpress-test-rg'
  $Script:aksName = 'aksapzdo'
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

  It 'Should contain an AKS cluster with given name' {
    #act
    $result = Confirm-AzBPAksCluster -ResourceGroupName $rgName -AKSName $aksName

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should not contain an AKS cluster with given name' {
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

  It "Should be an AKS CLuster named $aksName in a resource group named $rgName" {
    #act
    $result = Confirm-AzBPAksCluster -ResourceGroupName $rgName -AKSName $aksName

    #assert
    $result | Should -BeInResourceGroup $rgName
  }
}

Describe 'Verify AKS Node Pool' {
  BeforeAll {
    $Script:nodePoolName = 'apapzdo'
    $Script:noNodePoolName = 'noaksnodepool'
  }

  It "Should contain an AKS Node Pool named $nodePoolName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "AksNodePool"
      ResourceGroupName = $rgName
      ClusterName       = $aksName
      ResourceName      = $nodePoolName
    }

    #act and assert
    (Confirm-AzBPResource @params).Success | Should -Be $true
  }

  It "Should contain an AKS NodePool named $nodePoolName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "AksNodePool"
      ResourceGroupName = $rgName
      ClusterName       = $aksName
      ResourceName      = $nodePoolName
      PropertyKey       = "Name"
      PropertyValue     = $nodePoolName
    }

    #act and assert
    (Confirm-AzBPResource @params).Success | Should -Be $true
  }

  It "Should contain an AKS Node Pool with the name $aksNodePoolName" {
    (Confirm-AzBPAksNodePool -ResourceGroupName $rgName -ClusterName $aksName -Name $nodePoolName).Success
      | Should -Be $true
  }

  It "Should not contain an AKS Node Pool with the name $noNodePoolName" {
    #arrange
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      ClusterName = $aksName
      Name = $noNodePoolName
      ErrorAction = "SilentlyContinue"
    }

    #act and assert
    (Confirm-AzBPAksNodePool @params).Success | Should -Be $false
  }

  It "Should contain an AKS Node Pool named $aksName" {
    Confirm-AzBPAksNodePool -ResourceGroupName $rgName -ClusterName $aksName -Name $nodePoolName | Should -BeDeployed
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
