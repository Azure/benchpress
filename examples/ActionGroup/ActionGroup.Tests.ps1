BeforeAll {
  Import-Module Az.InfrastructureTesting
}

Describe 'Verify Action Group with Confirm-AzBPResource' {
  it 'Should contain an actiongroup named sampleaction' {
    #arrange
    $params = @{
      ResourceType      = "ActionGroup"
      ResourceName      = "sampleaction"
      ResourceGroupName = "rg-test"
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain an actiongroup named sampleaction' {
    #arrange
    $params = @{
      ResourceType      = "ActionGroup"
      ResourceName      = "sampleaction"
      ResourceGroupName = "rg-test"
      PropertyKey       = "GroupShortName"
      PropertyValue     = "sampleaction"
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
    $resourceGroupName = "rg-test"
    $actionGroupName = "sampleaction"

    #act
    $result = Confirm-AzBPActionGroup -ResourceGroupName $resourceGroupName -ActionGroupName $actionGroupName

    #assert
    $result.Success | Should -Be $true
  }
}

Describe 'Verify Action Group Does Not Exist' {
  it 'Should not contain an action group named sampleActionGroup' {
    #arrange
    $resourceGroupName = "rg-test"
    $actionGroupName = "nosampleaction"

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPActionGroup -ResourceGroupName $resourceGroupName -ActionGroupName $actionGroupName -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }
}

Describe 'Verify Action Group Exists with Custom Assertion' {
  it 'Should contain an action group named sampleaction' {
    $resourceGroupName = "rg-test"
    $actionGroupName = "sampleaction"

    #act
    $result = Confirm-AzBPActionGroup -ResourceGroupName $resourceGroupName -ActionGroupName $actionGroupName

    #assert
    $result | Should -BeDeployed
  }
}

Describe 'Verify Action Group Exists in Correct Location' {
  it 'Should contain an action group named sampleaction in global' {
    $resourceGroupName = "rg-test"
    $actionGroupName = "sampleaction"

    #act
    $result = Confirm-AzBPActionGroup -ResourceGroupName $resourceGroupName -ActionGroupName $actionGroupName

    #assert
    $result | Should -BeInLocation 'global'
  }
}

Describe 'Verify Action Group Exists in Resource Group' {
  it 'Should be in a resource group named rg-test' {
    $resourceGroupName = "rg-test"
    $actionGroupName = "sampleaction"

    #act
    $result = Confirm-AzBPActionGroup -ResourceGroupName $resourceGroupName -ActionGroupName $actionGroupName

    #assert
    $result | Should -BeInResourceGroup 'rg-test'
  }
}
