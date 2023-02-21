using module ./public/classes/ConfirmResult.psm1

BeforeAll {
  Import-Module $PSScriptRoot/ActionGroup.psm1
  Import-Module $PSScriptRoot/Authentication.psm1
  Import-Module Az
}

Describe "Confirm-ActionGroup" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName ActionGroup Connect-Account{}
    }

    It "Calls Get-AzActionGroup" {
      Mock -ModuleName ActionGroup Get-AzActionGroup{}
      Confirm-ActionGroup -ActionGroupName "agn" -ResourceGroupName "rgn"
      Should -Invoke -ModuleName ActionGroup -CommandName "Get-AzActionGroup" -Times 1
    }

    It "Sets the ErrorRecord when an exception is thrown" {
      Mock -ModuleName ActionGroup Get-AzActionGroup{ throw [Exception]::new("Exception") }
      $Results = Confirm-ActionGroup -ActionGroupName "agn" -ResourceGroupName "rgn"
      $Results.ErrorRecord | Should -Not -Be $null
    }
  }
}

AfterAll {
  Remove-Module ActionGroup
  Remove-Module Authentication
  Remove-Module Az
}
