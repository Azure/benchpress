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
