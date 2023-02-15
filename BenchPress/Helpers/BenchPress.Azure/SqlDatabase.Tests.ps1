BeforeAll {
  Import-Module $PSScriptRoot/Authentication.psm1
  Import-Module $PSScriptRoot/SqlDatabase.psm1
  Import-Module Az
}

Describe "Get-SqlDatabase" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName SqlDatabase Connect-Account{}
      Mock -ModuleName SqlDatabase Get-AzSqlDatabase{}
    }

    It "Calls Get-AzSqlDatabase without -DatbaseName when not provided" {
      Get-SqlDatabase -DatabaseName "dbn" -ServerName "sn" -ResourceGroupName "rgn"
      Should -Invoke -ModuleName SqlDatabase -CommandName "Get-AzSqlDatabase" -Times 1 `
        -ParameterFilter { $databaseName -eq $null; $serverName -eq "sn"; $resourceGroupName -eq "rgn" }
    }

    It "Calls Get-AzSqlDatabase with -DatbaseName when provided" {
      Get-SqlDatabase -DatabaseName "dbn" -ServerName "sn" -ResourceGroupName "rgn"
      Should -Invoke -ModuleName SqlDatabase -CommandName "Get-AzSqlDatabase" -Times 1 `
        -ParameterFilter { $databaseName -eq "dbn"; $serverName -eq "sn"; $resourceGroupName -eq "rgn" }
    }
  }
}

Describe "Get-SqlDatabaseExist" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName SqlDatabase Get-SqlDatabase{}
    }

    It "Calls Get-SqlDatabase" {
      Get-SqlDatabaseExist -DatabaseName "dbn" -ServerName "sn" -ResourceGroupName "rgn"
      Should -Invoke -ModuleName SqlDatabase -CommandName "Get-SqlDatabase" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Authentication
  Remove-Module SqlDatabase
}
