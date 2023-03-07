BeforeAll {
  Import-Module Az-InfrastructureTest
}

Describe 'Verify Synapse' {
  it 'Should contain a synapse workspace named samplesynws' {
    #arrange
    $rgName = 'rg-test'
    $workspaceName = 'samplesynws'

    #act
    $result = Confirm-AzBPSynapseWorkspace -ResourceGroupName $rgName -SynapseWorkspaceName $workspaceName

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain a synapse workspace with a spark pool named samplespark' {
    #arrange
    $params = @{
      ResourceGroupName    = 'rg-test'
      SynapseWorkspaceName = 'samplesynws'
      SynapseSparkPoolName = 'samplespark'
    }

    #act
    $result = Confirm-AzBPSynapseSparkPool @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain a synapse workspace with a sql pool named samplesql' {
    #arrange
    $params = @{
      ResourceGroupName    = 'rg-test'
      SynapseWorkspaceName = 'samplesynws'
      SynapseSqlPoolName   = 'samplesql'
    }

    #act
    $result = Confirm-AzBPSynapseSqlPool @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should not contain a synapse workspace named nosamplesynws' {
    #arrange
    $rgName = 'rg-test'
    $workspaceName = 'nosamplesynws'

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPSynapseWorkspace -ResourceGroupName $rgName -SynapseWorkspaceName $workspaceName `
      -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $true
  }
}
