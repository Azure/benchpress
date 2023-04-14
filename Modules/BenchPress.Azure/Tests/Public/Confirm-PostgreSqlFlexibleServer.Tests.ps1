BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-PostgreSqlFlexibleServer.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-PostgreSqlFlexibleServer" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzPostgreSqlFlexibleServer{}
    }

    It "Calls Get-AzPostgreSqlFlexibleServer" {
      Confirm-PostgreSqlFlexibleServer -ResourceGroupName "rgn" -Name "pgfs"
      Should -Invoke -CommandName "Get-AzPostgreSqlFlexibleServer" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
