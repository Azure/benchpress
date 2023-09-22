BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-StorageAccount.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-StorageAccount" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzStorageAccount{}
    }

    It "Calls Get-AzStorageAccount" {
      Confirm-StorageAccount -Name "sn" -ResourceGroupName "rgn"
      Should -Invoke -CommandName "Get-AzStorageAccount" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
