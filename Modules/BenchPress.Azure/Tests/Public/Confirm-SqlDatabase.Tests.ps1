BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-SqlDatabase.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-SqlDatabase" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzSqlDatabase{}
    }

    It "Calls Get-AzSqlDatabase without -DatbaseName when not provided" {
      Confirm-SqlDatabase -DatabaseName "dbn" -ServerName "sn" -ResourceGroupName "rgn"
      Should -Invoke -CommandName "Get-AzSqlDatabase" -Times 1 `
        -ParameterFilter { $databaseName -eq $null; $serverName -eq "sn"; $resourceGroupName -eq "rgn" }
    }

    It "Calls Get-AzSqlDatabase with -DatbaseName when provided" {
      Confirm-SqlDatabase -DatabaseName "dbn" -ServerName "sn" -ResourceGroupName "rgn"
      Should -Invoke -CommandName "Get-AzSqlDatabase" -Times 1 `
        -ParameterFilter { $databaseName -eq "dbn"; $serverName -eq "sn"; $resourceGroupName -eq "rgn" }
    }
  }
}

AfterAll {
  Remove-Module Az
}
