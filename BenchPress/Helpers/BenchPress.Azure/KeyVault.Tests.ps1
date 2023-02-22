using module ./public/classes/ConfirmResult.psm1

BeforeAll {
  Import-Module $PSScriptRoot/Authentication.psm1
  Import-Module $PSScriptRoot/KeyVault.psm1
  Import-Module Az
}

Describe "Confirm-KeyVault" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName KeyVault Connect-Account{}
    }

    It "Calls Get-AzKeyVault" {
      Mock -ModuleName KeyVault Get-AzKeyVault{}
      Confirm-KeyVault -Name "vn" -ResourceGroupName "rgn"
      Should -Invoke -ModuleName KeyVault -CommandName "Get-AzKeyVault" -Times 1
    }

    It "Sets the ErrorRecord when an exception is thrown" {
      Mock -ModuleName KeyVault Get-AzKeyVault{ throw [Exception]::new("Exception") }
      $Results = Confirm-KeyVault -Name "vn" -ResourceGroupName "rgn"
      $Results.ErrorRecord | Should -Not -Be $null
    }
  }
}

Describe "Confirm-KeyVaultSecret" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName KeyVault Connect-Account{}
    }

    It "Calls Get-AzKeyVaultSecret" {
      Mock -ModuleName KeyVault Get-AzKeyVaultSecret{}
      Confirm-KeyVaultSecret -Name "n" -KeyVaultName "kvn"
      Should -Invoke -ModuleName KeyVault -CommandName "Get-AzKeyVaultSecret" -Times 1
    }

    It "Sets the ErrorRecord when an exception is thrown" {
      Mock -ModuleName KeyVault Get-AzKeyVaultSecret{ throw [Exception]::new("Exception") }
      $Results = Confirm-KeyVaultSecret -Name "n" -KeyVaultName "kvn"
      $Results.ErrorRecord | Should -Not -Be $null
    }
  }
}

Describe "Confirm-KeyVaultKey" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName KeyVault Connect-Account{}
    }

    It "Calls Get-AzKeyVaultKey" {
      Mock -ModuleName KeyVault Get-AzKeyVaultKey{}
      Confirm-KeyVaultKey -Name "n" -KeyVaultName "kvn"
      Should -Invoke -ModuleName KeyVault -CommandName "Get-AzKeyVaultKey" -Times 1
    }

    It "Sets the ErrorRecord when an exception is thrown" {
      Mock -ModuleName KeyVault Get-AzKeyVaultKey{ throw [Exception]::new("Exception") }
      $Results = Confirm-KeyVaultKey -Name "n" -KeyVaultName "kvn"
      $Results.ErrorRecord | Should -Not -Be $null
    }
  }
}

Describe "Confirm-KeyVaultCertificate" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName KeyVault Connect-Account{}
    }

    It "Calls Get-AzKeyVaultCertificate" {
      Mock -ModuleName KeyVault Get-AzKeyVaultCertificate{}
      Confirm-KeyVaultCertificate -Name "n" -KeyVaultName "kvn"
      Should -Invoke -ModuleName KeyVault -CommandName "Get-AzKeyVaultCertificate" -Times 1
    }

    It "Sets the ErrorRecord when an exception is thrown" {
      Mock -ModuleName KeyVault Get-AzKeyVaultCertificate{ throw [Exception]::new("Exception") }
      $Results = Confirm-KeyVaultCertificate -Name "n" -KeyVaultName "kvn"
      $Results.ErrorRecord | Should -Not -Be $null
    }
  }
}

AfterAll {
  Remove-Module Authentication
  Remove-Module KeyVault
  Remove-Module Az
}
