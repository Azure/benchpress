BeforeAll {
  Import-Module "../BenchPress/Helpers/Azure/ActionGroup.psm1"
  Import-Module "../BenchPress/Helpers/Azure/Bicep.psm1"
}

Describe 'Verify Action Group Exists' {
  it 'Should contain a action group named sampleActionGroup' {
    #arrange
    $rgName = "test-rg"
    $actionGroupName = "sampleaction"

    #act
    $exists = Get-ActionGroupExists -resourceGroupName $rgName -actionGroupName $actionGroupName

    #assert
    $exists | Should -Be $true
  }
}

Describe 'Spin up , Tear down Action Group' {
  it 'Should deploy a bicep file.' {
    #arrange
    $bicepPath = "./actionGroup.bicep"
    $params = @{
      actionGroupName = "sampleaction"
      location    = "swedencentral"
    }
    #act
    $deployment = Deploy-BicepFeature $bicepPath $params "test-rg"
    #assert
    $deployment.ProvisioningState | Should -Be "Succeeded"

    #clean up
    Remove-BicepFeature $params
  }
}
