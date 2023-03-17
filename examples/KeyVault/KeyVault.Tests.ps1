BeforeAll {
  Import-Module Az.InfrastructureTesting
}

Describe 'Verify KeyVault Exists' {
  it 'Should contain a KeyVault with the given name' {
    #arrange
    $rgName = "rg-test"
    $kvName = "kvbenchpresstest"

    #act
    $result = Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $kvName

    #assert
    $result.Success | Should -Be $true
  }
}

Describe 'Verify samplekey Key in KeyVault Exists' {
  it 'Should contain a Key named samplekey in the KeyVault with the given name' {
    #arrange
    $kvName = "kvbenchpresstest"
    $kvKeyName = "samplekey"

    #act
    $result = Confirm-AzBPKeyVaultKey -KeyVaultName $kvName -Name $kvKeyName

    #assert
    $result | Should -Be $true
  }
}

Describe 'Verify samplesecret Secret in KeyVault Exists' {
  it 'Should contain a Secret named samplesecret in the KeyVault with the given name' {
    #arrange
    $kvName = "kvbenchpresstest"
    $kvSecretName = "samplesecret"

    #act
    $result = Confirm-AzBPKeyVaultSecret -KeyVaultName $kvName -Name $kvSecretName

    #assert
    $result | Should -Be $true
  }
}

Describe 'Verify KeyVault Does Not Exist' {
  it 'Should not contain a KeyVault with the given name' {
    #arrange
    $rgName = "rg-test"
    $kvName = "nokvbenchpresstest"

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $kvName -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }
}

Describe 'Verify KeyVault Exists with Custom Assertion' {
  it 'Should contain a KeyVault named kvbenchpresstest' {
    #arrange
    $rgName = "rg-test"
    $kvName = "kvbenchpresstest"

    #act
    $result = Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $kvName

    #assert
    $result | Should -BeDeployed
  }
}

Describe 'Verify KeyVault Exists in Correct Location' {
  it 'Should contain a KeyVault named rg-test in westus3' {
    #arrange
    $rgName = "rg-test"
    $kvName = "kvbenchpresstest"

    #act
    $result = Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $kvName

    #assert
    $result | Should -BeInLocation 'westus3'
  }
}

Describe 'Verify KeyVault Exists in Resource Group' {
  it 'Should be a KeyVault in a resource group named rg-test' {
    #arrange
    $rgName = "rg-test"
    $kvName = "kvbenchpresstest"

    #act
    $result = Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $kvName

    #assert
    $result | Should -BeInResourceGroup 'rg-test'
  }
}

Describe 'Verify KeyVault Key Exists with Custom Assertion' {
  it 'Should contain a KeyVault Key named samplekey' {
    #arrange
    $kvName = "kvbenchpresstest"
    $kvKeyName = "samplekey"

    #act
    $result = Confirm-AzBPKeyVaultKey -KeyVaultName $kvName -Name $kvKeyName

    #assert
    $result | Should -BeDeployed
  }
}

Describe 'Verify KeyVault Secret Exists with Custom Assertion' {
  it 'Should contain a KeyVault Secret named kvbenchpresstest' {
    #arrange
    $kvName = "kvbenchpresstest"
    $kvSecretName = "samplesecret"

    #act
    $result = Confirm-AzBPKeyVaultSecret -KeyVaultName $kvName -Name $kvSecretName

    #assert
    $result | Should -BeDeployed
  }
}

Describe 'Verify KeyVault Certificate Exists with Custom Assertion' {
  it 'Should contain a KeyVault Certificate named samplecertificate' {
    #arrange
    $kvName = "kvbenchpresstest"
    $kvCertName = "samplecertificate"

    #act
    $result = Confirm-AzBPKeyVaultCertificate -KeyVaultName $kvName -Name $kvCertName

    #assert
    $result | Should -BeDeployed
  }
}
