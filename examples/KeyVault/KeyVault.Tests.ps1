BeforeAll {
  Import-Module Az-InfrastructureTest
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
