BeforeAll {
  Import-Module $PSScriptRoot/KeyVault.psm1
  Import-Module Az
}

Describe "Get-KeyVault" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName KeyVault Get-AzKeyVault{}
    }

    It "Calls Get-AzKeyVault" {
      Get-KeyVault -Name "vn" -ResourceGroupName "rgn"
      Should -Invoke -ModuleName KeyVault -CommandName "Get-AzKeyVault" -Times 1
    }
  }
}

Describe "Get-KeyVaultExist" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName KeyVault Get-KeyVault{}
    }

    It "Calls Get-KeyVaultExist" {
      Get-KeyVaultExist -Name "vn" -ResourceGroupName "rgn"
      Should -Invoke -ModuleName KeyVault -CommandName "Get-KeyVault" -Times 1
    }
  }
}

Describe "Get-KeyVaultSecret" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName KeyVault Get-AzKeyVaultSecret{}
    }

    It "Calls Get-AzKeyVaultSecret" {
      Get-KeyVaultSecret -Name "n" -KeyVaultName "kvn"
      Should -Invoke -ModuleName KeyVault -CommandName "Get-AzKeyVaultSecret" -Times 1
    }
  }
}

Describe "Get-KeyVaultSecretExist" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName KeyVault Get-KeyVaultSecret{}
    }

    It "Calls Get-KeyVaultSecret" {
      Get-KeyVaultSecretExist -Name "n" -KeyVaultName "kvn"
      Should -Invoke -ModuleName KeyVault -CommandName "Get-KeyVaultSecret" -Times 1
    }
  }
}

Describe "Get-KeyVaultKey" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName KeyVault Get-AzKeyVaultKey{}
    }

    It "Calls Get-AzKeyVaultKey" {
      Get-KeyVaultKey -Name "n" -KeyVaultName "kvn"
      Should -Invoke -ModuleName KeyVault -CommandName "Get-AzKeyVaultKey" -Times 1
    }
  }
}

Describe "Get-KeyVaultKeyExist" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName KeyVault Get-KeyVaultKey{}
    }

    It "Calls Get-KeyVaultKey" {
      Get-KeyVaultKeyExist -Name "n" -KeyVaultName "kvn"
      Should -Invoke -ModuleName KeyVault -CommandName "Get-KeyVaultKey" -Times 1
    }
  }
}

Describe "Get-KeyVaultCertificate" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName KeyVault Get-AzKeyVaultCertificate{}
    }

    It "Calls Get-AzKeyVaultCertificate" {
      Get-KeyVaultCertificate -Name "n" -KeyVaultName "kvn"
      Should -Invoke -ModuleName KeyVault -CommandName "Get-AzKeyVaultCertificate" -Times 1
    }
  }
}

Describe "Get-KeyVaultCertificateExist" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName KeyVault Get-KeyVaultCertificate{}
    }

    It "Calls Get-KeyVaultCertificate" {
      Get-KeyVaultCertificateExist -Name "n" -KeyVaultName "kvn"
      Should -Invoke -ModuleName KeyVault -CommandName "Get-KeyVaultCertificate" -Times 1
    }
  }
}

AfterAll {
  Remove-Module KeyVault
}




