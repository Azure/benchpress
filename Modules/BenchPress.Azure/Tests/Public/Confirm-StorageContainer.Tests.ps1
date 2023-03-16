BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-StorageContainer.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-StorageContainer" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
    }

    It "Calls Get-AzStorageContainer" {
      Mock Get-AzStorageAccount{
        return New-MockObject -Type Microsoft.Azure.Commands.Management.Storage.Models.PSStorageAccount
      }
      Mock Get-AzStorageContainer{}
      Confirm-StorageContainer -Name "cn" -AccountName "sn" -ResourceGroupName "rgn"
      Should -Invoke -CommandName "Get-AzStorageAccount" -Times 1
      Should -Invoke -CommandName "Get-AzStorageContainer" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
