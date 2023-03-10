BeforeAll {
  Import-Module Az-InfrastructureTest
}

Describe 'Verify Operational Insights Workspace Exists' {
  it 'Should contain a Operational Insights Workspace named oiwTest' {
    #arrange
    $rgName = "rg-test"
    $oiwName = "oiwTest"

    #act
    $result = Confirm-AzBPOperationalInsightsWorkspace -ResourceGroupName $rgName -Name $oiwName

    #assert
    $result.Success | Should -Be $true
  }
}

Describe 'Verify Operational Insights Workspace Does Not Exist' {
  it 'Should not contain an Operational Insights Workspace named notOiwTest' {
    #arrange
    $rgName = "rg-test"
    $oiwName = "notOiwTest"

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      Name = $oiwName
      ErrorAction = SilentlyContinue
    }
    $result = Confirm-AzBPOperationalInsightsWorkspace @params

    #assert
    $result.Success | Should -Be $false
  }
}

Describe 'Verify Operational Insights Workspace Exists with Custom Assertion' {
  it 'Should contain a Operational Insights Workspace named oiwTest' {
    #arrange
    $rgName = "rg-test"
    $oiwName = "oiwTest"

    #act
    $result = Confirm-AzBPOperationalInsightsWorkspace -ResourceGroupName $rgName -Name $oiwName

    #assert
    $result | Should -BeDeployed
  }
}

Describe 'Verify Operational Insights Workspace Exists in Correct Location' {
  it 'Should contain a Operational Insights Workspace named oiwTest in westus3' {
    #arrange
    $rgName = "rg-test"
    $oiwName = "oiwTest"

    #act
    $result = Confirm-AzBPOperationalInsightsWorkspace -ResourceGroupName $rgName -Name $oiwName

    #assert
    $result | Should -BeInLocation 'westus3'
  }
}

Describe 'Verify Operational Insights Workspace Exists in Resource Group' {
  it 'Should be a Operational Insights Workspace in a resource group named rg-test' {
    #arrange
    $rgName = "rg-test"
    $oiwName = "oiwTest"

    #act
    $result = Confirm-AzBPOperationalInsightsWorkspace -ResourceGroupName $rgName -Name $oiwName

    #assert
    $result | Should -BeInResourceGroup 'rg-test'
  }
}
