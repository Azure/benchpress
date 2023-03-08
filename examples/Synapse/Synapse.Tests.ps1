BeforeAll {
  Import-Module Az-InfrastructureTest
}

Describe 'Verify Synapse Workspace' {
  it 'Should contain a synapse workspace named samplesynws' {
    #arrange
    $rgName = 'rg-test'
    $workspaceName = 'samplesynws'

    #act
    $result = Confirm-AzBPSynapseWorkspace -ResourceGroupName $rgName -WorkspaceName $workspaceName

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain a synapse workspace named samplesynws' {
    # Using custom assertion to check if the workspace is deployed
    $rgName = 'rg-test'
    $workspaceName = 'samplesynws'

    #act
    $result = Confirm-AzBPSynapseWorkspace -ResourceGroupName $rgName -WorkspaceName $workspaceName

    #assert
    $result | Should -BeDeployed
  }

  it 'Should contain a synapse workspace named samplesynws in westus3' {
    # Using custom assertion to check if the workspace is in the correct location
    $rgName = 'rg-test'
    $workspaceName = 'samplesynws'
    $location = 'westus3'

    #act
    $result = Confirm-AzBPSynapseWorkspace -ResourceGroupName $rgName -WorkspaceName $workspaceName

    #assert
    $result | Should -BeInLocation $location
  }

  it 'Should not contain a synapse workspace named nosamplesynws' {
    #arrange
    $rgName = 'rg-test'
    $workspaceName = 'nosamplesynws'

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPSynapseWorkspace -ResourceGroupName $rgName -WorkspaceName $workspaceName `
      -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }
}

Describe 'Verify Synapse Spark/SQL Pool' {
  it 'Should contain a synapse workspace with a spark pool named samplespark' {
    #arrange
    $params = @{
      ResourceGroupName    = 'rg-test'
      WorkspaceName        = 'samplesynws'
      SynapseSparkPoolName = 'samplespark'
    }

    #act
    $result = Confirm-AzBPSynapseSparkPool @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain a spark pool in westus3' {
    # Using custom assertion to check if the spark pool is in the correct location
    $params = @{
      ResourceGroupName    = 'rg-test'
      WorkspaceName        = 'samplesynws'
      SynapseSparkPoolName = 'samplespark'
    }
    $location = 'westus3'

    #act
    $result = Confirm-AzBPSynapseSparkPool @params

    #assert
    $result | Should -BeInLocation $location
  }

  it 'Should contain a synapse workspace with a sql pool named samplesql' {
    #arrange
    $params = @{
      ResourceGroupName  = 'rg-test'
      WorkspaceName      = 'samplesynws'
      SynapseSqlPoolName = 'samplesql'
    }

    #act
    $result = Confirm-AzBPSynapseSqlPool @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain a sql pool in westus3' {
    # Using custom assertion to check if the sql pool is in the correct location
    $params = @{
      ResourceGroupName  = 'rg-test'
      WorkspaceName      = 'samplesynws'
      SynapseSqlPoolName = 'samplesql'
    }
    $location = 'westus3'

    #act
    $result = Confirm-AzBPSynapseSqlPool @params

    #assert
    $result | Should -BeInLocation $location
  }
}
