BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-KeyVaultSecret.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-KeyVaultSecret" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
    }

    It "Calls Get-AzKeyVaultSecret" {
      Mock Get-AzKeyVaultSecret{}
      Confirm-KeyVaultSecret -Name "n" -KeyVaultName "kvn"
      Should -Invoke -CommandName "Get-AzKeyVaultSecret" -Times 1
    }

    It "Sets the ErrorRecord when an exception is thrown" {
      Mock Get-AzKeyVaultSecret{ throw [Exception]::new("Exception") }
      $Results = Confirm-KeyVaultSecret -Name "n" -KeyVaultName "kvn"
      $Results.ErrorRecord | Should -Not -Be $null
    }
  }
}

AfterAll {
  Remove-Module Az
}
