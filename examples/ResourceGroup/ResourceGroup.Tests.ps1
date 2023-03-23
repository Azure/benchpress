BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:location = 'westus3'
}

Describe 'Verify Resource Group Exists' {
  BeforeAll {
    $Script:notRgName = 'nottestrg'
  }

  it 'Should contain a resource group with given name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType      = "ResourceGroup"
      ResourceName      = $rgName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }


  it 'Should contain a resource group with expected property name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType      = "ResourceGroup"
      ResourceName      = $rgName
      PropertyKey       = 'ResourceGroupName'
      PropertyValue     = $rgName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain a resource group named $rgName' {
    #act
    $result = Confirm-AzBPResourceGroup -ResourceGroupName $rgName

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should not contain a resource group named $notRgName' {
    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPResourceGroup -ResourceGroupName $notRgName -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }

  it 'Should contain an Resource Group named $rgName' {
    #act
    $result = Confirm-AzBPResourceGroup -ResourceGroupName $rgName

    #assert
    $result | Should -BeDeployed
  }

  it 'Should contain an Resource Group named $rgName in $location' {
    #act
    $result = Confirm-AzBPResourceGroup -ResourceGroupName $rgName

    #assert
    $result | Should -BeInLocation $location
  }
}
