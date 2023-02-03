BeforeAll {
  Import-Module "../BenchPress/Helpers/BenchPress.Azure/BenchPress.Azure.psd1"
}

Describe 'Verify KeyVault Exists' {
  it 'Should contain a KeyVault with the given name' {
    #arrange
    $rgName = "rg-test"
    $kvName = "kvbenchpresstest"

    #act
    $exists = Get-AzBPKeyVault -ResourceGroupName $rgName -Name $kvName

    #assert
    $exists | Should -Not -BeNullOrEmpty
  }
}

Describe 'Verify samplekey Key in KeyVault Exists' {
  it 'Should contain a Key named samplekey in the KeyVault with the given name' {
    #arrange
    $kvName = "kvbenchpresstest"
    $kvKeyName = "samplekey"

    #act
    $exists = Get-AzBPKeyVaultKey -KeyVaultName $kvName -Name $kvKeyName

    #assert
    $exists | Should -Not -BeNullOrEmpty
  }
}

Describe 'Verify samplekey Key in KeyVault Exists' {
  it 'Should contain a Key named samplekey in the KeyVault with the given name' {
    #arrange
    $kvName = "kvbenchpresstest"
    $kvKeyName = "samplekey"

    #act
    $exists = Get-AzBPKeyVaultKeyExist -KeyVaultName $kvName -Name $kvKeyName

    #assert
    $exists | Should -Be $true
  }
}

Describe 'Verify samplesecret Secret in KeyVault Exists' {
  it 'Should contain a Secret named samplesecret in the KeyVault with the given name' {
    #arrange
    $kvName = "kvbenchpresstest"
    $kvSecretName = "samplesecret"

    #act
    $exists = Get-AzBPKeyVaultSecret -KeyVaultName $kvName -Name $kvSecretName

    #assert
    $exists | Should -Not -BeNullOrEmpty
  }
}

Describe 'Verify samplesecret Secret in KeyVault Exists' {
  it 'Should contain a Secret named samplesecret in the KeyVault with the given name' {
    #arrange
    $kvName = "kvbenchpresstest"
    $kvSecretName = "samplesecret"

    #act
    $exists = Get-AzBPKeyVaultSecretExist -KeyVaultName $kvName -Name $kvSecretName

    #assert
    $exists | Should -Be $true
  }
}

Describe 'Verify KeyVault Exists' {
  it 'Should contain a KeyVault with the given name' {
    #arrange
    $rgName = "rg-test"
    $kvName = "kvbenchpresstest"

    #act
    $exists = Get-AzBPKeyVaultExist -ResourceGroupName $rgName -Name $kvName

    #assert
    $exists | Should -Be $true
  }
}

Describe 'Spin up , Tear down KeyVault' {
  it 'Should deploy a bicep file.' {
    #arrange
    $rgName = "rg-test"
    $location = "westus3"
    $kvName = "kvbenchpresstest"
    $kvKeyName = "samplekey"
    $kvSecretName = "samplesecret"
    $bicepPath = "./keyVault.bicep"
    $params = @{
      name           = $kvName
      location       = $location
    }

    #act
    $deployment = Deploy-AzBPBicepFeature -BicepPath $bicepPath -Params $params -ResourceGroupName $rgName

    $currentUser=(Get-AzContext | Select-Object -Property Account -ExpandProperty Account | Select-Object Id -ExpandProperty Id)
    $userId=(Get-AzAdUser -UserPrincipalName $currentUser | Select-Object Id -ExpandProperty Id)
    Set-AzKeyVaultAccessPolicy -VaultName $kvName -ObjectId $userId -PermissionsToSecrets "All" -PermissionsToKeys "All" -PermissionsToCertificates "All"

    $kvExists = Get-AzBPKeyVaultExist -ResourceGroupName $rgName -Name $kvName
    $kvKeyExists = Get-AzBPKeyVaultKeyExist -KeyVaultName $kvName -Name $kvKeyName
    $kvSecretExists = Get-AzBPKeyVaultSecretExist -KeyVaultName $kvName -Name $kvSecretName

    #assert
    $deployment.ProvisioningState | Should -Be "Succeeded"
    $kvExists | Should -Be $true
    $kvKeyExists | Should -Be $true
    $kvSecretExists | Should -Be $true

    #clean up
    Remove-AzBPBicepFeature -ResourceGroupName $rgName
  }
}




