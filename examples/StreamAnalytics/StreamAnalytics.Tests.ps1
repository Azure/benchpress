BeforeAll {
  Import-Module Az-InfrastructureTest
}

Describe 'Verify Stream Analytics Cluster' {
  it 'Should contain a Stream Analytics Cluster with the given name' {
    #arrange
    $rgName = 'rg-test'
    $name = 'teststreamcluster'

    #act
    $result = Confirm-AzBPStreamAnalyticsCluster -ResourceGroupName $rgName -Name $name

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should not contain a Stream Analytics Cluster with the given name' {
    #arrange
    $rgName = 'rg-test'
    $name = 'noteststreamcluster'

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPStreamAnalyticsCluster -ResourceGroupName $rgName -Name $name -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }

  it 'Should contain a Stream Analytics Cluster named teststreamcluster' {
    #arrange
    $rgName = 'rg-test'
    $name = 'teststreamcluster'

    #act
    $result = Confirm-AzBPStreamAnalyticsCluster -ResourceGroupName $rgName -Name $name

    #assert
    $result | Should -BeDeployed
  }

  it 'Should contain a Stream Analytics Cluster named teststreamcluster in westus3' {
    #arrange
    $rgName = 'rg-test'
    $name = 'teststreamcluster'

    #act
    $result = Confirm-AzBPStreamAnalyticsCluster -ResourceGroupName $rgName -Name $name
    #assert
    $result | Should -BeInLocation 'westus3'
  }

  it 'Should be a Stream Analytics Cluster in a resource group named rg-test' {
    #arrange
    $rgName = 'rg-test'
    $name = 'teststreamcluster'

    #act
    $result = Confirm-AzBPStreamAnalyticsCluster -ResourceGroupName $rgName -Name $name

    #assert
    $result | Should -BeInResourceGroup 'rg-test'
  }
}
