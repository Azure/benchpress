BeforeAll {
  Import-Module Az-InfrastructureTest
}

Describe 'Verify Action Group Exists' {
  it 'Should contain a action group named sampleaction' {
    #arrange
    $resourceGroupName = "test-rg"
    $actionGroupName = "sampleaction"

    #act
    $result = Confirm-AzBPActionGroup -ResourceGroupName $resourceGroupName -ActionGroupName $actionGroupName

    #assert
    $result.Success | Should -Be $true
  }
}

Describe 'Verify Action Group Does Not Exist' {
  it 'Should not contain a action group named sampleActionGroup' {
    #arrange
    $resourceGroupName = "test-rg"
    $actionGroupName = "nosampleaction"

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPActionGroup -ResourceGroupName $resourceGroupName -ActionGroupName $actionGroupName -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }
}
