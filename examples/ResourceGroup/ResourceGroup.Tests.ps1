BeforeAll {
  Import-Module Az.InfrastructureTesting
}

Describe 'Verify Resource Group Exists' {
  it 'Should contain a resource group named rg-test' {
    #arrange
    $rgName = "rg-test"

    #act
    $result = Confirm-AzBPResourceGroup -ResourceGroupName $rgName

    #assert
    $result.Success | Should -Be $true
  }
}

Describe 'Verify Resource Group Does Not Exist' {
  it 'Should not contain a resource group named rg-test' {
    #arrange
    $rgName = "rg-test"

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPResourceGroup -ResourceGroupName $rgName -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }
}

Describe 'Verify Resource Group Exists with Custom Assertion' {
  it 'Should contain an Resource Group named rg-test' {
    #arrange
    $rgName = "rg-test"

    #act
    $result = Confirm-AzBPResourceGroup -ResourceGroupName $rgName

    #assert
    $result | Should -BeDeployed
  }
}

Describe 'Verify Resource Group Exists in Correct Location' {
  it 'Should contain an Resource Group named rg-test in westus3' {
    #arrange
    $rgName = "rg-test"

    #act
    $result = Confirm-AzBPResourceGroup -ResourceGroupName $rgName

    #assert
    $result | Should -BeInLocation 'westus3'
  }
}
