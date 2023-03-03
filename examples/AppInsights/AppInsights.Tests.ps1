BeforeAll {
  Import-Module Az-InfrastructureTest
}

Describe 'Verify App Insights' {
  it 'Should contain an application insights with the given name' {
    #arrange
    $rgName = "rg-test"
    $appInsightsName = "appinsightstest"

    #act
    $result = Confirm-AzBPAppInsights -ResourceGroupName $rgName -Name $appInsightsName

    #assert
    $result.Success | Should -Be $true
  }
}

Describe 'Verify App Insights Does Not Exist' {
  it 'Should not contain an application insights with the given name' {
    #arrange
    $rgName = "rg-test"
    $acrName = "noappinsightstest"

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPAppInsights -ResourceGroupName $rgName -Name $acrName -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }
}
