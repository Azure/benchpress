$ROOT_PATH = $PSScriptRoot | split-path -parent | split-path -parent | split-path -parent | split-path -parent | split-path -parent

BeforeAll {
  Import-Module -Name $ROOT_PATH/Benchpress/Helpers/Azure/ResourceGroup.psm1
  Import-Module -Name $ROOT_PATH/Benchpress/Helpers/Azure/Bicep.psm1
}

Describe 'Verify Resource Group Exists' {
  it 'Should contain a resource group named rg-test-bicep' {
    #arrange
    $rgName = "rg-test-bicep"

    #act
    $exists = Get-ResourceGroupExists($rgName)

    #assert
    $exists | Should -Be $true
  }
}

Describe 'Spin up , Tear down Resource Group' {
  it 'Should deploy a bicep file.' {
    #get bicep file path
    $bicepPath = "$ROOT_PATH/samples/dotnet/samples/pwsh/resourceGroup.bicep"

    #pass required bicep parameteres
    $params = @{
      resourceGroupName        = "rg-test-bicep"
      location                 = "eastus"
      environment              = "ocwtest"
    }

    #deploy bicep suing bicep helper
    $deployment = Deploy-BicepFeature $bicepPath $params

    #assert deployment succeeded or not
    $deployment.ProvisioningState | Should -Be "Succeeded"

    #clean up deployed resources
    Remove-BicepFeature $params.resourceGroupName
  }
}
