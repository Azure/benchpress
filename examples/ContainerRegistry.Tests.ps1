BeforeAll {
  Import-Module "../BenchPress/Helpers/Azure/BenchPress.Azure.psd1"
}

Describe 'Verify Container Registry Exists' {
  it 'Should contain a container registry with the given name' {
    #arrange
    $rgName = "rg-test"
    $acrName = "acrbenchpresstest1"

    #act
    $exists = Get-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName

    #assert
    $exists | Should -Not -BeNullOrEmpty
  }
}

Describe 'Verify Container Registry Exists' {
  it 'Should contain a container registry with the given name' {
    #arrange
    $rgName = "rg-test"
    $acrName = "acrbenchpresstest1"

    #act
    $exists = Get-AzBPContainerRegistryExist -ResourceGroupName $rgName -Name $acrName

    #assert
    $exists | Should -Be $true
  }
}

Describe 'Spin up , Tear down Container Registry' {
  it 'Should deploy a bicep file.' {
    #arrange
    $resourceGroupName = "rg-test"
    $bicepPath = "./containerRegistry.bicep"
    $params = @{
      name           = "acrbenchpresstest1"
      location       = "westus3"
    }

    #act
    $deployment = Deploy-AzBPBicepFeature -BicepPath $bicepPath -Params $params -ResourceGroupName $resourceGroupName

    #assert
    $deployment.ProvisioningState | Should -Be "Succeeded"

    #clean up
    Remove-AzBPBicepFeature -ResourceGroupName $resourceGroupName
  }
}
