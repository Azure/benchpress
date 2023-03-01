BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-KeyVaultKey.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-KeyVaultKey" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
    }

    It "Calls Get-AzKeyVaultKey" {
      Mock Get-AzKeyVaultKey{}
      Confirm-KeyVaultKey -Name "n" -KeyVaultName "kvn"
      Should -Invoke -CommandName "Get-AzKeyVaultKey" -Times 1
    }

    It "Sets the ErrorRecord when an exception is thrown" {
      Mock Get-AzKeyVaultKey{ throw [Exception]::new("Exception") }
      $Results = Confirm-KeyVaultKey -Name "n" -KeyVaultName "kvn"
      $Results.ErrorRecord | Should -Not -Be $null
    }
  }
}

AfterAll {
  Remove-Module Az
}
