BeforeAll {
  Import-Module Az-InfrastructureTest
}

Describe 'Verify Resource Group Exists Using Custom Assertions' {
  it 'Should contain a resource group named testrg' {
    #arrange
    $rgName = "testrg"

    #act
    $result = Confirm-AzBPResourceGroup -ResourceGroupName $rgName

    #assert
    $result | Should -BeDeployed
  }
}

Describe 'Verify Resource Group Does Not Exist Using Custom Assertions' {
  it 'Should not contain a resource group named testrg2' {
    #arrange
    $rgName = "testrg2"

    #act
    $result = Confirm-AzBPResourceGroup -ResourceGroupName $rgName -ErrorAction SilentlyContinue

    #assert
    $result | Should -Not -BeDeployed
  }
}

Describe 'Verify App Service Plan Exists in Correct Location' {
  it 'Should contain an app service plan named appservicetestbp in westus3' {
    #arrange
    $rgName = "testrg"
    $appServicePlanName = 'appservicetestbp'

    #act
    $result = Confirm-AzBPAppServicePlan -ResourceGroupName $rgName -AppServicePlanName $appServicePlanName

    #assert
    # to fix, use westus3
    $result | Should -BeInLocation 'westus3'
  }
}

Describe 'Verify App Service Plan Exists in Correct Resource Group' {
  it 'Should contain an app service plan named appservicetestbp in testrg' {
    #arrange
    $rgName = "testrg"
    $appServicePlanName = 'appservicetestbp'

    #act
    $result = Confirm-AzBPAppServicePlan -ResourceGroupName $rgName -AppServicePlanName $appServicePlanName

    #assert
    $result | Should -BeInResourceGroup 'testrg'
  }
}

Describe 'Verify Web App Does Not Exist in Location' {
  it 'Should not contain a resource group named testrg in West US 2' {
    #arrange
    $rgName = "testrg"
    $webappName = 'testwebappBP'

    #act
    $result = Confirm-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webappName

    #assert
    $result | Should -Not -BeInLocation 'westus2'
  }
}

Describe 'Verify Web App Does Not Exist in Resource Group' {
  it 'Should not be contained in a resource group named testrg' {
    #arrange
    $rgName = "testrg"
    $webappName = 'testwebappBP'

    #act
    $result = Confirm-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webappName

    #assert
    $result | Should -Not -BeInResourceGroup 'westus2'
  }
}

Describe 'Verify Key Vault Exists in Location' {
  it 'Should contain a KV in westus3' {
    #arrange
    $rgName = "testrg"
    $kvName = "KVtestBP"

    #act
    $result = Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $kvName

    #assert
    # to fix, use westus3
    $result | Should -BeInLocation 'westus3'
  }
}

Describe 'Verify Key Vault Key Exists in Resource Group' {
  it 'Should contain a KV key in testrg' {
    #arrange
    $kvName = "KVtestBP"
    $kvKeyName = "testkey"
    
    #act
    $result = Confirm-AzBPKeyVaultKey -KeyVaultName $kvName -Name $kvKeyName

    #assert
    $result | Should -BeInResourceGroup 'testrg'
  }
}

Describe 'Verify Key Vault Certificate Exists in Resource Group' {
  it 'Should contain a KV Certificate in testrg' {
    #arrange
    $kvName = "KVtestBP"
    $kvCertName = "testcert"

    #act
    $result = Confirm-AzBPKeyVaultCertificate -Name $kvName -KeyVaultName $kvCertName

    #assert
    $result | Should -BeInResourceGroup 'testrg'
  }
}

Describe 'Verify Container Registry Exists in Resource Group' {
  it 'Should contain a CR in testrg' {
    #arrange
    $rgName = "testrg"

    #act
    $result = Confirm-AzBPContainerRegistry -Name "testcontaineregistry" -ResourceGroupName $rgName

    #assert
    $result | Should -BeInResourceGroup 'testrg'
  }
}

Describe 'Verify Container Registry Does Not Exist in Resource Group' {
  it 'Should not contain a CR in testrg2' {
    #arrange
    $rgName = "testrg"

    #act
    $result = Confirm-AzBPContainerRegistry -Name "testcontaineregistry" -ResourceGroupName $rgName

    #assert
    $result | Should -Not -BeInResourceGroup 'testrg2'
  }
}
