using module ./public/classes/ConfirmResult.psm1

BeforeAll {
  Import-Module $PSScriptRoot/Authentication.psm1
  Import-Module $PSScriptRoot/StorageAccount.psm1
  Import-Module Az
}

Describe "Confirm-StorageAccount" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName StorageAccount Connect-Account{}
    }

    It "Calls Get-AzStorageAccount" {
      Mock -ModuleName StorageAccount Get-AzStorageAccount{}
      Confirm-StorageAccount -Name "sn" -ResourceGroupName "rgn"
      Should -Invoke -ModuleName StorageAccount -CommandName "Get-AzStorageAccount" -Times 1
    }

    It "Sets the ErrorRecord when an exception is thrown" {
      Mock -ModuleName StorageAccount Get-AzStorageAccount{ throw [Exception]::new("Exception") }
      $Results = Confirm-StorageAccount -Name "sn" -ResourceGroupName "rgn"
      $Results.ErrorRecord | Should -Not -Be $null
    }
  }
}

AfterAll {
  Remove-Module Authentication
  Remove-Module StorageAccount
  Remove-Module Az
}
