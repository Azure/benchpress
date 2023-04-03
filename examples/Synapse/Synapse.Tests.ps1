BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:workSpaceName = 'samplesynws'
  $Script:location = 'westus3'
}

Describe 'Verify Synapse Workspace' {
  BeforeAll {
    $Script:noWorkspaceName = 'nosamplesynws'
  }

  It 'Should contain a Synapse Workspace with the given name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType = "SynapseWorkspace"
      ResourceGroupName = $rgName
      ResourceName = $workSpaceName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Synapse Workspace named $workSpaceName - ConfirmAzBPResource" {
    #arrange
    $params = @{
      ResourceType = "SynapseWorkspace"
      ResourceGroupName = $rgName
      ResourceName = $workSpaceName
      PropertyKey = 'Name'
      PropertyValue = $workSpaceName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a synapse workspace named $workSpaceName" {
    Confirm-AzBPSynapseWorkspace -ResourceGroupName $rgName -WorkspaceName $workspaceName | Should -BeSuccessful
  }

  It "Should contain a synapse workspace named $workSpaceName in $location" {
    Confirm-AzBPSynapseWorkspace -ResourceGroupName $rgName -WorkspaceName $workspaceName
    | Should -BeInLocation $location
  }

  It "Should contain a synapse workspace named $workSpaceName in $rgName" {
    Confirm-AzBPSynapseWorkspace -ResourceGroupName $rgName -WorkspaceName $workspaceName
    | Should -BeInResourceGroup $rgName
  }

  It "Should not contain a synapse workspace named $noWorkspaceName" {
    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      WorkspaceName = $noWorkspaceName
      ErrorAction = 'SilentlyContinue'
    }

    #act and assert
    Confirm-AzBPSynapseWorkspace @params | Should -Not -BeSuccessful
  }
}

Describe 'Verify Synapse Spark/SQL Pool' {
  BeforeAll {
    $Script:sparkPoolName = 'samplespark'
    $Script:sqlPoolName = 'samplesql'
  }

  It 'Should contain a Synapse Spark Pool with the given name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType = "SynapseSparkPool"
      ResourceGroupName = $rgName
      WorkspaceName = $workSpaceName
      ResourceName = $sparkPoolName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Synapse Spark Pool named $sparkPoolName - ConfirmAzBPResource" {
    #arrange
    $params = @{
      ResourceType = "SynapseSparkPool"
      ResourceGroupName = $rgName
      WorkspaceName = $workSpaceName
      ResourceName = $sparkPoolName
      PropertyKey = 'Name'
      PropertyValue = $sparkPoolName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a synapse workspace with a spark pool named $sparkPoolName" {
    #arrange
    $params = @{
      ResourceGroupName    = $rgName
      WorkspaceName        = $workSpaceName
      SynapseSparkPoolName = $sparkPoolName
    }

    #act
    Confirm-AzBPSynapseSparkPool @params | Should -BeSuccessful
  }

  It "Should contain a spark pool in $location" {
    #arrange
    $params = @{
      ResourceGroupName    = $rgName
      WorkspaceName        = $workSpaceName
      SynapseSparkPoolName = $sparkPoolName
    }

    #act
    Confirm-AzBPSynapseSparkPool @params | Should -BeInLocation $location
  }

  It "Should contain a spark pool in $rgName" {
    #arrange
    $params = @{
      ResourceGroupName    = $rgName
      WorkspaceName        = $workSpaceName
      SynapseSparkPoolName = $sparkPoolName
    }
    #act
    Confirm-AzBPSynapseSparkPool @params | Should -BeInResourceGroup $rgName
  }

#######################################################################################################################

  It 'Should contain a Synapse SQL Pool with the given name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType = "SynapseSqlPool"
      ResourceGroupName = $rgName
      WorkspaceName = $workSpaceName
      ResourceName = $sqlPoolName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Synapse SQL Pool named $sqlPoolName - ConfirmAzBPResource" {
    #arrange
    $params = @{
      ResourceType = "SynapseSqlPool"
      ResourceGroupName = $rgName
      WorkspaceName = $workSpaceName
      ResourceName = $sqlPoolName
      PropertyKey = 'Name'
      PropertyValue = $sqlPoolName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a synapse workspace with a SQL pool named $sqlPoolName" {
    #arrange
    $params = @{
      ResourceGroupName  = $rgName
      WorkspaceName      = $workSpaceName
      SynapseSqlPoolName = $sqlPoolName
    }

    #act
    Confirm-AzBPSynapseSqlPool @params | Should -BeSuccessful
  }

  It "Should contain a SQL pool in $location" {
    #arrange
    $params = @{
      ResourceGroupName  = $rgName
      WorkspaceName      = $workSpaceName
      SynapseSqlPoolName = $sqlPoolName
    }

    #act
    Confirm-AzBPSynapseSqlPool @params | Should -BeInLocation $location
  }

  It "Should contain a SQL pool in $rgName" {
    #arrange
    $params = @{
      ResourceGroupName  = $rgName
      WorkspaceName      = $workSpaceName
      SynapseSqlPoolName = $sqlPoolName
    }

    #act
    Confirm-AzBPSynapseSqlPool @params | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
