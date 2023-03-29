BeforeAll {
  Import-Module ../../bin/BenchPress.Azure.psm1

  $Script:rgName = 'rg-test'
  $Script:kvName = 'kvbenchpresstest'
  $Script:location = 'westus3'
}

Describe 'Verify Key Vault' {
  BeforeAll {
    $Script:noKvName = 'nokvbenchpresstest'
    $Script:kvKeyName = 'samplekey'
    $Script:kvSecretName = 'samplesecret'
  }

  It "Should contain a Key Vault named $kvName - Confirm-AzBPResource" {
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


  It "Should contain a Key Vault named $kvName - Confirm-AzBPResource" {
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

  It "Should contain a Key Vault named $kvName" {
    #act
    $result = Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $kvName

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain a Key named $kvKeyName in the Key Vault named $kvName" {
    #act
    $result = Confirm-AzBPKeyVaultKey -KeyVaultName $kvName -Name $kvKeyName

    #assert
    $result | Should -Be $true
  }

  It "Should contain a Secret named $kvSecretName in the Key Vault named $kvName" {
    #act
    $result = Confirm-AzBPKeyVaultSecret -KeyVaultName $kvName -Name $kvSecretName

    #assert
    $result | Should -Be $true
  }

  It "Should not contain a Key Vault named $noKvName" {
    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $noKvName -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }

  It "Should contain a Key Vault named $kvName" {
    #act
    $result = Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $kvName

    #assert
    $result | Should -BeDeployed
  }

  It "Should contain a Key Vault named $kvName in $location" {
    #act
    $result = Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $kvName

    #assert
    $result | Should -BeInLocation $location
  }

  It "Should contain a Key Vault named $kvName in $rgName" {
    #act
    $result = Confirm-AzBPKeyVault -ResourceGroupName $rgName -Name $kvName

    #assert
    $result | Should -BeInResourceGroup $rgName
  }

  It "Should contain a Key Vault Key named $kvKeyName" {
    #act
    $result = Confirm-AzBPKeyVaultKey -KeyVaultName $kvName -Name $kvKeyName

    #assert
    $result | Should -BeDeployed
  }

  It "Should contain a Key Vault Secret named $kvSecretName" {
    #act
    $result = Confirm-AzBPKeyVaultSecret -KeyVaultName $kvName -Name $kvSecretName

    #assert
    $result | Should -BeDeployed
  }
}

AfterAll {
  Get-Module Az-InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
