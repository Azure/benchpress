BeforeAll {
  Import-Module Az.InfrastructureTesting
}

Describe 'Verify Resource Exists' {
  it 'Should have a resource group called rg-test' {
    #arrange
    $rgName = "rg-test"

    #act
    $result = Get-AzBPResourceByType -ResourceType "ResourceGroup" -ResourceName "${rgName}"

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should have a virtual machine named testvm' {
    #arrange
    $resourceName = "testvm"
    $rgName = "rg-test"

    #act
    $result = Get-AzBPResourceByType -ResourceType "VirtualMachine" -ResourceName "${resourceName}" -ResourceGroupName "${rgName}"

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should have a resource with name of testvm' {
    #arrange
    $resourceName = "testvm"

    #act
    $exists = Get-AzBPResource -ResourceName "${resourceName}"

    #assert
    $exists | Should -Not -Be $null
  }
}
