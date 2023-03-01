BeforeAll {
  Import-Module Az-InfrastructureTest
}
Describe 'Spin up , Tear down Action Group' {
  it 'Should deploy a bicep file.' {
    #arrange
    $resourceGroupName = "rg-test"
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
    #Remove-AzBPBicepFeature -ResourceGroupName $resourceGroupName
  }
}
