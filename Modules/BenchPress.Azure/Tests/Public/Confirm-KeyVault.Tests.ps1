BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-KeyVault.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-KeyVault" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
    }

    It "Calls Get-AzKeyVault" {
      Mock Get-AzKeyVault{}
      Confirm-KeyVault -Name "vn" -ResourceGroupName "rgn"
      Should -Invoke -CommandName "Get-AzKeyVault" -Times 1
    }

    It "Sets the ErrorRecord when an exception is thrown" {
      Mock Get-AzKeyVault{ throw [Exception]::new("Exception") }
      $Results = Confirm-KeyVault -Name "vn" -ResourceGroupName "rgn"
      $Results.ErrorRecord | Should -Not -Be $null
    }
  }
}

AfterAll {
  Remove-Module Az
}
