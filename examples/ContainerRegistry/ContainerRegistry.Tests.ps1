BeforeAll {
  Import-Module Az.InfrastructureTesting
}

$resourceType = "ContainerRegistry"
$resourceName = "testcontaineregistry"
$rgName = "rg-test"

Describe 'Verify Container Registry with Confirm-AzBPResource' {
  it 'Should contain a container registry named testcontaineregistry' {
    #arrange
    $params = @{
      ResourceType      = $resourceType
      ResourceName      = $resourceName
      ResourceGroupName = $rgName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain a container registry named testcontaineregistry is Standard' {
    #arrange
    $params = @{
      ResourceType      = $resourceType
      ResourceName      = $resourceName
      ResourceGroupName = $rgName
      PropertyKey       = "SkuName"
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
    $rgName = $rgName
    $acrName = $resourceName

    #act
    $result = Confirm-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName

    #assert
    $result.Success | Should -Be $true
  }
}

Describe 'Verify Container Registry Does Not Exist' {
  it 'Should not contain a container registry with the given name' {
    #arrange
    $rgName = $rgName
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
    $rgName = $rgName
    $acrName = $resourceName

    #act
    $result = Confirm-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName

    #assert
    $result | Should -BeDeployed
  }
}

Describe 'Verify Container Registry Exists in Correct Location' {
  it 'Should contain a Container Registry named acrbenchpresstest in westus3' {
    #arrange
    $rgName = $rgName
    $acrName = $resourceName

    #act
    $result = Confirm-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName

    #assert
    $result | Should -BeInLocation 'westus3'
  }
}

Describe 'Verify Container Registry Exists in Resource Group' {
  it 'Should be in a resource group named rg-test' {
    #arrange
    $rgName = $rgName
    $acrName = $resourceName

    #act
    $result = Confirm-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName

    #assert
    $result | Should -BeInResourceGroup $rgName
  }
}
