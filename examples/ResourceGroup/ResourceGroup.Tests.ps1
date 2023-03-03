BeforeAll {
  Import-Module Az-InfrastructureTest
}

Describe 'Verify Resource Group Exists' {
  it 'Should contain a resource group named tflintrules' {
    #arrange
    $rgName = "rgtest"

    #act
    $result = Confirm-AzBPResourceGroup -ResourceGroupName $rgName

    #assert
    $result.Success | Should -Be $true
  }
}

Describe 'Verify Resource Group Does Not Exist' {
  it 'Should not contain a resource group named tflintrules' {
    #arrange
    $rgName = "rgtest"

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPResourceGroup -ResourceGroupName $rgName -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }
}
