BeforeAll {
  Import-Module "../BenchPress/Helpers/BenchPress.Azure/BenchPress.Azure.psd1"
}

Describe 'Verify Resource Group Exists' {
  it 'Should contain a resource group named tflintrules' {
    #arrange
    $rgName = "tflintrules"

    #act
    $exists = Get-AzBPResourceGroupExist -ResourceGroupName $rgName

    #assert
    $exists | Should -Be $true
  }
}

Describe 'Verify Resource Group Does Not Exist' {
  it 'Should not contain a resource group named tflintrules' {
    #arrange
    $rgName = "tflintrules"

    #act
    # The '-ErrorAction SilentlyContinue' command
    # suppresses errors when the underlying functions
    # don't find the resource; remove this to see the error
    $exists = Get-AzBPResourceGroupExist -ResourceGroupName $rgName -ErrorAction SilentlyContinue

    #assert
    $exists | Should -Be $false
  }
}

Describe 'Spin up , Tear down Resource Group' {
  it 'Should deploy a bicep file.' {
    #arrange
    $resourceGroupName = "rg-test"
    $bicepPath = "./resourceGroup.bicep"
    $params = @{
      name        = $resourceGroupName
      location    = "westus"
      environment = "ocwtest"
    }
    #act
    $deployment = Deploy-AzBPBicepFeature -BicepPath $bicepPath -Params $params -ResourceGroupName $resourceGroupName
    #assert
    $deployment.ProvisioningState | Should -Be "Succeeded"

    #clean up
    Remove-AzBPBicepFeature -ResourceGroupName $resourceGroupName
  }
}
