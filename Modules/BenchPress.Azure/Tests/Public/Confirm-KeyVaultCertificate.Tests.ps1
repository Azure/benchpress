BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-KeyVaultCertificate.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-KeyVaultCertificate" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzKeyVaultCertificate{}
    }

    It "Calls Get-AzKeyVaultCertificate" {
      Confirm-KeyVaultCertificate -Name "n" -KeyVaultName "kvn"
      Should -Invoke -CommandName "Get-AzKeyVaultCertificate" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
