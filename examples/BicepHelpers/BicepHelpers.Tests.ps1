BeforeAll {
  Import-Module Az.InfrastructureTesting
}
Describe 'Spin up , Tear down Action Group' {
  It 'Should deploy a bicep file.' {
    #arrange
    $resourceGroupName = "rg-test"
    $bicepPath = "../ActionGroup/actionGroup.bicep"
    $params = @{
      actionGroupName = "sampleaction"
      location        = "swedencentral"
    }

    #act
    $deployment = Deploy-AzBPBicepFeature -BicepPath $bicepPath -Params $params -ResourceGroupName $resourceGroupName

    #assert
    $deployment.ProvisioningState | Should -Be "Succeeded"

    #clean up
    #Remove-AzBPBicepFeature -ResourceGroupName $resourceGroupName
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
