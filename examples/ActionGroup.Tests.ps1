BeforeAll {
  Import-Module "../BenchPress/Helpers/BenchPress.Azure/BenchPress.Azure.psd1"
}

Describe 'Verify Action Group Exists' {
  it 'Should contain a action group named sampleaction' {
    #arrange
    $resourceGroupName = "test-rg"
    $actionGroupName = "sampleaction"

    #act
    $exists = Get-AzBPActionGroupExist -ResourceGroupName $resourceGroupName -ActionGroupName $actionGroupName

    #assert
    $exists | Should -Be $true
  }
}

Describe 'Verify Action Group Does Not Exist' {
  it 'Should not contain a action group named sampleActionGroup' {
    #arrange
    $resourceGroupName = "test-rg"
    $actionGroupName = "sampleActionGroup"

    #act
    # The '-ErrorAction SilentlyContinue' command
    # suppresses errors when the underlying functions
    # don't find the resource; remove this to see the error
    $exists = Get-AzBPActionGroupExist -ResourceGroupName $resourceGroupName -ActionGroupName $actionGroupName -ErrorAction SilentlyContinue

    #assert
    $exists | Should -Be $false
  }
}

Describe 'Spin up , Tear down Action Group' {
  it 'Should deploy a bicep file.' {
    #arrange
    $resourceGroupName = "test-rg"
    $bicepPath = "./actionGroup.bicep"
    $params = @{
      actionGroupName = "sampleaction"
      location    = "swedencentral"
    }

    #act
    $deployment = Deploy-AzBPBicepFeature -BicepPath $bicepPath -Params $params -ResourceGroupName $resourceGroupName

    #assert
    $deployment.ProvisioningState | Should -Be "Succeeded"

    #clean up
    Remove-AzBPBicepFeature -ResourceGroupName $resourceGroupName
  }
}
