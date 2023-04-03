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
    $Script:kvAccessPolicyObjectId = 'svcprinoid'
  }

  It 'Should contain a keyVault with given name - Confirm-AzBPResource' {
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


  It "Should contain a Key Vault with an Access Policy for $kvAccessPolicyObjectId" {
    #arrange
    $params = @{
      ResourceType      = "KeyVault"
      ResourceGroupName = $rgName
      ResourceName      = $kvName
      PropertyKey       = 'AccessPolicies[0].ObjectId'
      PropertyValue     = $kvAccessPolicyObjectId
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should contain a KeyVault with the given name' {
    #act
    $result = Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $kvName

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain a Key named $kvKeyName in the KeyVault with the given name" {
    #act
    $result = Confirm-AzBPKeyVaultKey -KeyVaultName $kvName -Name $kvKeyName

    #assert
    $result | Should -Be $true
  }

  It "Should contain a Secret named $kvSecretName in the KeyVault with the given name" {
    #act
    $result = Confirm-AzBPKeyVaultSecret -KeyVaultName $kvName -Name $kvSecretName

    #assert
    $result | Should -Be $true
  }

  It 'Should not contain a KeyVault with the given name' {
    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $noKvName -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }

  It "Should contain a KeyVault named $kvName" {
    #act
    $result = Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $kvName

    #assert
    $result | Should -BeDeployed
  }

  It "Should contain a KeyVault named $kvName in $location" {
    #act
    $result = Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $kvName

    #assert
    $result | Should -BeInLocation $location
  }

  It "Should be a KeyVault in a resource group named $rgName" {
    #act
    $result = Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $kvName

    #assert
    $result | Should -BeInResourceGroup $rgName
  }

  It "Should contain a KeyVault Key named $kvKeyName" {
    #act
    $result = Confirm-AzBPKeyVaultKey -KeyVaultName $kvName -Name $kvKeyName

    #assert
    $result | Should -BeDeployed
  }

  It "Should contain a KeyVault Secret named $kvSecretName" {
    #act
    $result = Confirm-AzBPKeyVaultSecret -KeyVaultName $kvName -Name $kvSecretName

    #assert
    $result | Should -BeDeployed
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
