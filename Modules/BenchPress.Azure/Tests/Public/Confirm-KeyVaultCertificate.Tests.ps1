BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-KeyVaultCertificate.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-KeyVaultCertificate" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
    }

    It "Calls Get-AzKeyVaultCertificate" {
      Mock Get-AzKeyVaultCertificate{}
      Confirm-KeyVaultCertificate -Name "n" -KeyVaultName "kvn"
      Should -Invoke -CommandName "Get-AzKeyVaultCertificate" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
