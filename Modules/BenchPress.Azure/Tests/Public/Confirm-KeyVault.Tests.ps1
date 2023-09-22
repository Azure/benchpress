BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-KeyVault.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-KeyVault" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzKeyVault{}
    }

    It "Calls Get-AzKeyVault" {
      Confirm-KeyVault -Name "vn" -ResourceGroupName "rgn"
      Should -Invoke -CommandName "Get-AzKeyVault" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
