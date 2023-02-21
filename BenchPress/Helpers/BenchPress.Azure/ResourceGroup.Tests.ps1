using module ./public/classes/ConfirmResult.psm1

BeforeAll {
  Import-Module $PSScriptRoot/Authentication.psm1
  Import-Module $PSScriptRoot/ResourceGroup.psm1
  Import-Module Az
}

Describe "Confirm-ResourceGroup" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName ResourceGroup Connect-Account{}
    }

    It "Calls Get-AzResourceGroup" {
      Mock -ModuleName ResourceGroup Get-AzResourceGroup{}
      Confirm-ResourceGroup -ResourceGroupName "rgn"
      Should -Invoke -ModuleName ResourceGroup -CommandName "Get-AzResourceGroup" -Times 1
    }

    It "Sets the ErrorRecord when an exception is thrown" {
      Mock -ModuleName ResourceGroup Get-AzResourceGroup{ throw [Exception]::new("Exception") }
      $Results = Confirm-ResourceGroup -ResourceGroupName "rgn"
      $Results.ErrorRecord | Should -Not -Be $null
    }
  }
}

AfterAll {
  Remove-Module Authentication
  Remove-Module ResourceGroup
  Import-Module Az
}
