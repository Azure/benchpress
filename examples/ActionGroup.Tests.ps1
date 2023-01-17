BeforeAll {
  Import-Module "../BenchPress/Helpers/Azure/BenchPress.Azure.psd1"
}

Describe 'Verify Action Group Exists' {
  it 'Should contain a action group named sampleActionGroup' {
    #arrange
    $resourceGroupName = "test-rg"
    $actionGroupName = "sampleaction"

    #act
    $exists = Get-AzBPActionGroupExist -ResourceGroupName $resourceGroupName -ActionGroupName $actionGroupName

    #assert
    $exists | Should -Be $true
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
    $deployment = Deploy-AzBPBicepFeature $bicepPath $params $resourceGroupName

    #assert
    $deployment.ProvisioningState | Should -Be "Succeeded"

    #clean up
    Remove-AzBPBicepFeature $resourceGroupName
  }
}
