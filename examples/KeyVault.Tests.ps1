BeforeAll {
  Import-Module "../BenchPress/Helpers/Azure/KeyVault.psm1"
  Import-Module "../BenchPress/Helpers/Azure/Bicep.psm1"
}

Describe 'Verify KeyVault Exists' {
  it 'Should contain a KeyVault with the given name' {
    #arrange
    $rgName = "rg-test"
    $kvName = "kvbenchpresstest"

    #act
    $exists = Get-KeyVault -ResourceGroupName $rgName -Name $kvName

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
    $exists = Get-KeyVaultKey -KeyVaultName $kvName -Name $kvKeyName

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
    $exists = Get-KeyVaultKeyExist -KeyVaultName $kvName -Name $kvKeyName

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
    $exists = Get-KeyVaultSecret -KeyVaultName $kvName -Name $kvSecretName

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
    $exists = Get-KeyVaultSecretExist -KeyVaultName $kvName -Name $kvSecretName

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
    $exists = Get-KeyVaultExist -ResourceGroupName $rgName -Name $kvName

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
    $deployment = Deploy-BicepFeature $bicepPath $params $rgName

    $currentUser=(Get-AzContext | Select-Object -Property Account -ExpandProperty Account | Select-Object Id -ExpandProperty Id)
    $userId=(Get-AzAdUser -UserPrincipalName $currentUser | Select-Object Id -ExpandProperty Id)
    Set-AzKeyVaultAccessPolicy -VaultName $kvName -ObjectId $userId -PermissionsToSecrets "All" -PermissionsToKeys "All" -PermissionsToCertificates "All"

    $kvExists = Get-KeyVaultExist -ResourceGroupName $rgName -Name $kvName
    $kvKeyExists = Get-KeyVaultKeyExist -KeyVaultName $kvName -Name $kvKeyName
    $kvSecretExists = Get-KeyVaultSecretExist -KeyVaultName $kvName -Name $kvSecretName

    #assert
    $deployment.ProvisioningState | Should -Be "Succeeded"
    $kvExists | Should -Be $true
    $kvKeyExists | Should -Be $true
    $kvSecretExists | Should -Be $true

    #clean up
    Remove-BicepFeature $rgName
  }
}
