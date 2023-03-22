BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:actionGroupName = 'sampleaction'
  $Script:location = 'global'
}

Describe 'Verify Action Group' {
  BeforeAll {
    $Script:noActionGroupName = "noactiongroup"
  }

  it 'Should contain an actiongroup named sampleaction - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType      = 'ActionGroup'
      ResourceName      = $actionGroupName
      ResourceGroupName = $rgName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain an actiongroup named sampleaction - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType      = 'ActionGroup'
      ResourceName      = $actionGroupName
      ResourceGroupName = $rgName
      PropertyKey       = "GroupShortName"
      PropertyValue     = $actionGroupName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain an action group with given name' {
    #act
    $result = Confirm-AzBPActionGroup -ResourceGroupName $rgName -ActionGroupName $actionGroupName

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should not contain an action group with given name' {
    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPActionGroup -ResourceGroupName $rgName -ActionGroupName $noActionGroupName -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }

  it "Should contain an action group named $actionGroupName" {
    #act
    $result = Confirm-AzBPActionGroup -ResourceGroupName $rgName -ActionGroupName $actionGroupName

    #assert
    $result | Should -BeDeployed
  }

  it "Should contain an action group named $actionGroupName in $location" {
    #act
    $result = Confirm-AzBPActionGroup -ResourceGroupName $rgName -ActionGroupName $actionGroupName

    #assert
    $result | Should -BeInLocation $location
  }

  it "Should be an action group named $actionGroupName in a resource group named $rgName" {
    #act
    $result = Confirm-AzBPActionGroup -ResourceGroupName $rgName -ActionGroupName $actionGroupName

    #assert
    $result | Should -BeInResourceGroup $rgName
  }
}
