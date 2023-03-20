BeforeAll {
  Import-Module Az.InfrastructureTesting
}

$resourceType = "ActionGroup"
$resourceName = "sampleaction"
$rgName = "rg-test"

Describe 'Verify Action Group with Confirm-AzBPResource' {
  it 'Should contain an actiongroup named sampleaction' {
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

  it 'Should contain an actiongroup named sampleaction' {
    #arrange
    $params = @{
      ResourceType      = $resourceType
      ResourceName      = $resourceName
      ResourceGroupName = $rgName
      PropertyKey       = "GroupShortName"
      PropertyValue     = $resourceName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }
}

Describe 'Verify Action Group Exists' {
  it 'Should contain an action group named sampleaction' {
    #arrange
    $rgName = $rgName
    $actionGroupName = $resourceName

    #act
    $result = Confirm-AzBPActionGroup -ResourceGroupName $rgName -ActionGroupName $actionGroupName

    #assert
    $result.Success | Should -Be $true
  }
}

Describe 'Verify Action Group Does Not Exist' {
  it 'Should not contain an action group named sampleActionGroup' {
    #arrange
    $rgName = $rgName
    $actionGroupName = "noActionGroup"

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPActionGroup -ResourceGroupName $rgName -ActionGroupName $actionGroupName -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }
}

Describe 'Verify Action Group Exists with Custom Assertion' {
  it 'Should contain an action group named sampleaction' {
    #arrange
    $rgName = $rgName
    $actionGroupName = $resourceName

    #act
    $result = Confirm-AzBPActionGroup -ResourceGroupName $rgName -ActionGroupName $actionGroupName

    #assert
    $result | Should -BeDeployed
  }
}

Describe 'Verify Action Group Exists in Correct Location' {
  it 'Should contain an action group named sampleaction in global' {
    #arrange
    $rgName = $rgName
    $actionGroupName = $resourceName

    #act
    $result = Confirm-AzBPActionGroup -ResourceGroupName $rgName -ActionGroupName $actionGroupName

    #assert
    $result | Should -BeInLocation 'global'
  }
}

Describe 'Verify Action Group Exists in Resource Group' {
  it 'Should be in a resource group named rg-test' {
    #arrange
    $rgName = $rgName
    $actionGroupName = $resourceName

    #act
    $result = Confirm-AzBPActionGroup -ResourceGroupName $rgName -ActionGroupName $actionGroupName

    #assert
    $result | Should -BeInResourceGroup $rgName
  }
}
