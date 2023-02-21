using module ./public/classes/ConfirmResult.psm1

BeforeAll {
  Import-Module $PSScriptRoot/Authentication.psm1
  Import-Module $PSScriptRoot/SqlServer.psm1
  Import-Module Az
}

Describe "Confirm-SqlServer" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName SqlServer Connect-Account{}
    }

    It "Calls Get-AzSqlServer" {
      Mock -ModuleName SqlServer Get-AzSqlServer{}
      Confirm-SqlServer -ServerName "sn" -ResourceGroupName "rgn"
      Should -Invoke -ModuleName SqlServer -CommandName "Get-AzSqlServer" -Times 1
    }

    It "Sets the ErrorRecord when an exception is thrown" {
      Mock -ModuleName SqlServer Get-AzSqlServer{ throw [Exception]::new("Exception") }
      $Results = Confirm-SqlServer -ServerName "sn" -ResourceGroupName "rgn"
      $Results.ErrorRecord | Should -Not -Be $null
    }
  }
}

AfterAll {
  Remove-Module Authentication
  Remove-Module SqlServer
  Remove-Module Az
}
