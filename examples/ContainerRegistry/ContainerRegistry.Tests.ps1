BeforeAll {
  Import-Module Az-InfrastructureTest
}

Describe 'Verify Container Registry' {
  it 'Should contain a container registry with the given name' {
    #arrange
    $rgName = "rg-test"
    $acrName = "acrbenchpresstest"

    #act
    $result = Confirm-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName

    #assert
    $result.Success | Should -Be $true
  }
}

Describe 'Verify Container Registry Does Not Exist' {
  it 'Should not contain a container registry with the given name' {
    #arrange
    $rgName = "rg-test"
    $acrName = "noacrbenchpresstest"

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }
}
