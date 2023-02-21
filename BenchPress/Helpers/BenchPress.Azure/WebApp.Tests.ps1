using module ./public/classes/ConfirmResult.psm1

BeforeAll {
  Import-Module $PSScriptRoot/Authentication.psm1
  Import-Module $PSScriptRoot/WebApp.psm1
  Import-Module Az
}

Describe "Confirm-WebApp" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName WebApp Connect-Account{}
    }

    It "Calls Get-AzWebApp" {
      Mock -ModuleName WebApp Get-AzWebApp{}
      Confirm-WebApp -WebAppName "wan" -ResourceGroupName "rgn"
      Should -Invoke -ModuleName WebApp -CommandName "Get-AzWebApp" -Times 1
    }

    It "Sets the ErrorRecord when an exception is thrown" {
      Mock -ModuleName WebApp Get-AzWebApp{ throw [Exception]::new("Exception") }
      $Results = Confirm-WebApp -WebAppName "wan" -ResourceGroupName "rgn"
      $Results.ErrorRecord | Should -Not -Be $null
    }
  }
}

AfterAll {
  Remove-Module Authentication
  Remove-Module WebApp
}
