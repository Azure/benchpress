BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:oiwName = 'oiwName'
  $Script:location = 'westus3'
}

Describe 'Verify Operational Insights Workspace Exists' {
  BeforeAll {
    $Script:notOiwName = 'notOiwName'
  }

  it 'Should contain a Operational Insights Workspace with given name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType      = "OperationalInsightsWorkspace"
      ResourceGroupName = $rgName
      ResourceName      = $oiwName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }


  it 'Should contain a Operational Insights Workspace with expected property name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType      = "OperationalInsightsWorkspace"
      ResourceGroupName = $rgName
      ResourceName      = $oiwName
      PropertyKey       = 'Name'
      PropertyValue     = $oiwName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain a Operational Insights Workspace named $oiwName' {
    #act
    $result = Confirm-AzBPOperationalInsightsWorkspace -ResourceGroupName $rgName -Name $oiwName

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should not contain an Operational Insights Workspace named not $oiwName' {
    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      Name = $notOiwName
    }
    $result = Confirm-AzBPOperationalInsightsWorkspace @params -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }

  it 'Should contain a Operational Insights Workspace named $oiwName' {
    #act
    $result = Confirm-AzBPOperationalInsightsWorkspace -ResourceGroupName $rgName -Name $oiwName

    #assert
    $result | Should -BeDeployed
  }

  it 'Should contain a Operational Insights Workspace named $oiwName in $location' {
    #act
    $result = Confirm-AzBPOperationalInsightsWorkspace -ResourceGroupName $rgName -Name $oiwName

    #assert
    $result | Should -BeInLocation $location
  }

  it 'Should be a Operational Insights Workspace in a resource group named $rgName' {
    #act
    $result = Confirm-AzBPOperationalInsightsWorkspace -ResourceGroupName $rgName -Name $oiwName

    #assert
    $result | Should -BeInResourceGroup $rgName
  }
}
