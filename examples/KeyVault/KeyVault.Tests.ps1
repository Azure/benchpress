BeforeAll {
  Import-Module ../../bin/BenchPress.Azure.psm1

  $Script:rgName = 'rg-test'
  $Script:kvName = 'kvbenchpresstest'
  $Script:location = 'westus3'
}

Describe 'Verify KeyVault' {
  BeforeAll {
    $Script:noKvName = 'nokvbenchpresstest'
    $Script:kvKeyName = 'samplekey'
    $Script:kvSecretName = 'samplesecret'
  }

  it 'Should contain a keyVault with given name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType      = "KeyVault"
      ResourceGroupName = $rgName
      ResourceName      = $kvName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }


  it 'Should contain a keyVault with expected property name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType      = "KeyVault"
      ResourceGroupName = $rgName
      ResourceName      = $kvName
      PropertyKey       = 'VaultName'
      PropertyValue     = $kvName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain a KeyVault with the given name' {
    #act
    $result = Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $kvName

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain a Key named samplekey in the KeyVault with the given name' {
    #act
    $result = Confirm-AzBPKeyVaultKey -KeyVaultName $kvName -Name $kvKeyName

    #assert
    $result | Should -Be $true
  }

  it 'Should contain a Secret named samplesecret in the KeyVault with the given name' {
    #act
    $result = Confirm-AzBPKeyVaultSecret -KeyVaultName $kvName -Name $kvSecretName

    #assert
    $result | Should -Be $true
  }

  it 'Should not contain a KeyVault with the given name' {
    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $noKvName -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }

  it 'Should contain a KeyVault named kvbenchpresstest' {
    #act
    $result = Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $kvName

    #assert
    $result | Should -BeDeployed
  }

  it 'Should contain a KeyVault named rg-test in westus3' {
    #act
    $result = Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $kvName

    #assert
    $result | Should -BeInLocation $location
  }

  it 'Should be a KeyVault in a resource group named rg-test' {
    #act
    $result = Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $kvName

    #assert
    $result | Should -BeInResourceGroup 'rg-test'
  }

  it 'Should contain a KeyVault Key named samplekey' {
    #act
    $result = Confirm-AzBPKeyVaultKey -KeyVaultName $kvName -Name $kvKeyName

    #assert
    $result | Should -BeDeployed
  }

  it 'Should contain a KeyVault Secret named kvbenchpresstest' {
    #act
    $result = Confirm-AzBPKeyVaultSecret -KeyVaultName $kvName -Name $kvSecretName

    #assert
    $result | Should -BeDeployed
  }
}
