using module ./public/classes/ConfirmResult.psm1

BeforeAll {
  Import-Module $PSScriptRoot/Authentication.psm1
  Import-Module $PSScriptRoot/SqlDatabase.psm1
  Import-Module Az
}

Describe "Confirm-SqlDatabase" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName SqlDatabase Connect-Account{}
    }

    It "Calls Get-AzSqlDatabase without -DatbaseName when not provided" {
      Mock -ModuleName SqlDatabase Get-AzSqlDatabase{}
      Confirm-SqlDatabase -DatabaseName "dbn" -ServerName "sn" -ResourceGroupName "rgn"
      Should -Invoke -ModuleName SqlDatabase -CommandName "Get-AzSqlDatabase" -Times 1 `
        -ParameterFilter { $databaseName -eq $null; $serverName -eq "sn"; $resourceGroupName -eq "rgn" }
    }

    It "Calls Get-AzSqlDatabase with -DatbaseName when provided" {
      Mock -ModuleName SqlDatabase Get-AzSqlDatabase{}
      Confirm-SqlDatabase -DatabaseName "dbn" -ServerName "sn" -ResourceGroupName "rgn"
      Should -Invoke -ModuleName SqlDatabase -CommandName "Get-AzSqlDatabase" -Times 1 `
        -ParameterFilter { $databaseName -eq "dbn"; $serverName -eq "sn"; $resourceGroupName -eq "rgn" }
    }

    It "Sets the ErrorRecord when an exception is thrown" {
      Mock -ModuleName SqlDatabase Get-AzSqlDatabase{ throw [Exception]::new("Exception") }
      $Results = Confirm-SqlDatabase -DatabaseName "dbn" -ServerName "sn" -ResourceGroupName "rgn"
      $Results.ErrorRecord | Should -Not -Be $null
    }
  }
}

AfterAll {
  Remove-Module Authentication
  Remove-Module SqlDatabase
  Remove-Module Az
}
