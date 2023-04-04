BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:kvName = 'kvbenchpresstest'
  $Script:location = 'westus3'
}

Describe 'Verify KeyVault' {
  BeforeAll {
    $Script:noKvName = 'nokvbenchpresstest'
    $Script:kvKeyName = 'samplekey'
    $Script:kvSecretName = 'samplesecret'
    $Script:kvCertificateName = 'samplecert'
    $Script:kvAccessPolicyObjectId = 'svcprinoid'
  }

  It 'Should contain a keyVault with given name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType      = "KeyVault"
      ResourceGroupName = $rgName
      ResourceName      = $kvName
    }

    Confirm-AzBPResource @params | Should -BeSuccessful
  }


  It "Should contain a Key Vault with an Access Policy for $kvAccessPolicyObjectId" {
    #arrange
    $params = @{
      ResourceType      = "KeyVault"
      ResourceGroupName = $rgName
      ResourceName      = $kvName
      PropertyKey       = 'AccessPolicies[0].ObjectId'
      PropertyValue     = $kvAccessPolicyObjectId
    }

    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a KeyVault named $kvName" {
    Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $kvName | Should -BeSuccessful
  }

  It "Should contain a Key named $kvKeyName in the KeyVault with the given name" {
    Confirm-AzBPKeyVaultKey -KeyVaultName $kvName -Name $kvKeyName | Should -BeSuccessful
  }

  It "Should contain a Secret named $kvSecretName in the KeyVault with the given name" {
    Confirm-AzBPKeyVaultSecret -KeyVaultName $kvName -Name $kvSecretName | Should -BeSuccessful
  }

  It "Should contain a Certificate named $kvCertificateName in the KeyVault with the given name" {
    Confirm-AzBPKeyVaultCertificate -KeyVaultName $kvName -Name $kvCertificateName | Should -BeSuccessful
  }

  It 'Should not contain a KeyVault with the given name' {
    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $noKvName -ErrorAction SilentlyContinue
    | Should -Not -BeSuccessful
  }

  It "Should contain a KeyVault named $kvName in $location" {
    Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $kvName | Should -BeInLocation $location
  }

  It "Should be a KeyVault in a resource group named $rgName" {
    Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $kvName | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
