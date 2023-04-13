BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:kvName = 'kvbenchpresstest'
  $Script:noKvName = 'nokvbenchpresstest'
  $Script:kvKeyName = 'samplekey'
  $Script:kvSecretName = 'samplesecret'
  $Script:kvCertificateName = 'samplecert'
  $Script:kvAccessPolicyObjectId = 'svcprinoid'
  $Script:location = 'westus3'
}

Describe 'Verify Key Vault' {
  It "Should contain a Key Vault named $kvName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "KeyVault"
      ResourceGroupName = $rgName
      ResourceName      = $kvName
    }

    # act and assert
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

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Key Vault named $kvName" {
    Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $kvName | Should -BeSuccessful
  }

  It "Should contain a Key named $kvKeyName in the Key Vault named $kvName" {
    Confirm-AzBPKeyVaultKey -KeyVaultName $kvName -Name $kvKeyName | Should -BeSuccessful
  }

  It "Should contain a Secret named $kvSecretName in the Key Vault named $kvName" {
    Confirm-AzBPKeyVaultSecret -KeyVaultName $kvName -Name $kvSecretName | Should -BeSuccessful
  }

  It "Should not contain a Key Vault named $noKvName" {
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $noKvName -ErrorAction SilentlyContinue
    | Should -Not -BeSuccessful
  }

  It "Should contain a Key Vault named $kvName in $location" {
    Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $kvName | Should -BeInLocation $location
  }

  It "Should contain a Key Vault named $kvName in $rgName" {
    Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $kvName | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
