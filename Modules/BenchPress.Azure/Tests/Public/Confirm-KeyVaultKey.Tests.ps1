BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-KeyVaultKey.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-KeyVaultKey" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzKeyVaultKey{}
    }

    It "Calls Get-AzKeyVaultKey" {
      Confirm-KeyVaultKey -Name "n" -KeyVaultName "kvn"
      Should -Invoke -CommandName "Get-AzKeyVaultKey" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
