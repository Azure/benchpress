BeforeAll {
  Import-Module "../BenchPress/Helpers/BenchPress.Azure/BenchPress.Azure.psd1"
}

Describe 'Verify Resource Exists' {
  it 'should has a resource with type of ResourceGroup and name of AzurePortal' {
    #arrange
    $rgName = "AzurePortal"

    #act
    $exists = Get-AzBPResourceByType -ResourceType ResourceGroup -ResourceName "${rgName}"

    #assert
    $exists | Should -Be $true
  }

  it 'should has a resource with type of VirtualMachine and name of testVM' {
    #arrange
    $resourceName = "testVM"
    $rgName = "AzurePortal"

    #act
    $exists = Get-AzBPResourceByType -ResourceType VirtualMachine -ResourceName "${resourceName}" -ResourceGroupName "${rgName}"

    #assert
    $exists | Should -Be $true
  }

  it 'should has a resource with name of AzurePortal' {
    #arrange
    $resourceName = "testVM"

    #act
    $exists = Get-AzBPResource -ResourceName "${resourceName}"

    #assert
    $exists | Should -Be $true
  }

  it 'should has a resource with name of testVM' {
    #arrange
    $resourceName = "testVM"

    #act
    $exists = Get-AzBPResource -ResourceName "${resourceName}"

    #assert
    $exists | Should -Be $true
  }
}




