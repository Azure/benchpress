BeforeAll {
  Import-Module Az.InfrastructureTesting
}

Describe 'Verify Container Registry with Confirm-AzBPResource' {
  it 'Should contain a container registry named testcontaineregistry' {
    #arrange
    $params = @{
      ResourceType      = "ContainerRegistry"
      ResourceName      = "testcontaineregistry"
      ResourceGroupName = "rg-test"
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain a container registry named testcontaineregistry is Standard' {
    #arrange
    $params = @{
      ResourceType      = "ContainerRegistry"
      ResourceName      = "testcontaineregistry"
      ResourceGroupName = "rg-test"
      PropertyKey       = "Sku.Name"
      PropertyValue     = "Standard"
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }
}

Describe 'Verify Container Registry with Confirm-AzBPContainerRegistry' {
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

Describe 'Verify Container Registry Exists with Custom Assertion' {
  it 'Should contain a Container Registry named acrbenchpresstest' {
    #arrange
    $rgName = "rg-test"
    $acrName = "acrbenchpresstest"

    #act
    $result = Confirm-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName

    #assert
    $result | Should -BeDeployed
  }
}

Describe 'Verify Container Registry Exists in Correct Location' {
  it 'Should contain a Container Registry named acrbenchpresstest in westus3' {
    #arrange
    $rgName = "rg-test"
    $acrName = "acrbenchpresstest"

    #act
    $result = Confirm-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName

    #assert
    $result | Should -BeInLocation 'westus3'
  }
}

Describe 'Verify Container Registry Exists in Resource Group' {
  it 'Should be in a resource group named rg-test' {
    #arrange
    $rgName = "rg-test"
    $acrName = "acrbenchpresstest"

    #act
    $result = Confirm-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName

    #assert
    $result | Should -BeInResourceGroup 'rg-test'
  }
}
