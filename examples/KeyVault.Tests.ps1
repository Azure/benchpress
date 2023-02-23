BeforeAll {
  Import-Module "../BenchPress/Helpers/BenchPress.Azure/BenchPress.Azure.psd1"
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
    $kvName = "kvbenchpresstest"

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $kvName -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
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

    $kvExists = Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $kvName
    $kvKeyExists = Confirm-AzBPKeyVaultKey -KeyVaultName $kvName -Name $kvKeyName
    $kvSecretExists = Confirm-AzBPKeyVaultSecret -KeyVaultName $kvName -Name $kvSecretName

    #assert
    $deployment.ProvisioningState | Should -Be "Succeeded"
    $kvExists.Success | Should -Be $true
    $kvKeyExists.Success | Should -Be $true
    $kvSecretExists.Success | Should -Be $true

    #clean up
    Remove-AzBPBicepFeature -ResourceGroupName $rgName
  }
}
