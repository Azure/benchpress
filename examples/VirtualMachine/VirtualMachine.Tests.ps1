BeforeAll {
  Import-Module Az.InfrastructureTesting
}

Describe 'Verify Virtual Machine Exists' {
  it 'Should contain a Virtual Machine with the given name' {
    #arrange
    $rgName = 'rg-test'
    $vmName = 'simpleLinuxVM1'

    #act
    $result = Confirm-AzBPVirtualMachine -ResourceGroupName $rgName -VirtualMachineName $vmName

    #assert
    $result.Success | Should -Be $true
  }
}

Describe 'Verify Virtual Machine Does Not Exist' {
  it 'Should not contain a Virtual Machine with the given name' {
    #arrange
    $rgName = 'rg-test'
    $vmName = 'noSimpleLinuxVM1'

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPVirtualMachine -ResourceGroupName $rgName -VirtualMachineName $vmName -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }
}

Describe 'Verify Virtual Machine Exists with Custom Assertion' {
  it 'Should contain a Virtual Machine named simpleLinuxVM1' {
    #arrange
    $rgName = 'rg-test'
    $vmName = 'simpleLinuxVM1'

    #act
    $result = Confirm-AzBPVirtualMachine -ResourceGroupName $rgName -VirtualMachineName $vmName

    #assert
    $result | Should -BeDeployed
  }
}

Describe 'Verify Virtual Machine Exists in Correct Location' {
  it 'Should contain an Virtual Machine named simpleLinuxVM1 in westus3' {
    #arrange
    $rgName = 'rg-test'
    $vmName = 'simpleLinuxVM1'

    #act
    $result = Confirm-AzBPVirtualMachine -ResourceGroupName $rgName -VirtualMachineName $vmName

    #assert
    $result | Should -BeInLocation 'westus3'
  }
}

Describe 'Verify Virtual Machine Exists in Resource Group' {
  it 'Should be a Virtual Machine in a resource group named rg-test' {
    #arrange
    $rgName = 'rg-test'
    $vmName = 'simpleLinuxVM1'

    #act
    $result = Confirm-AzBPVirtualMachine -ResourceGroupName $rgName -VirtualMachineName $vmName

    #assert
    $result | Should -BeInResourceGroup 'rg-test'
  }
}
