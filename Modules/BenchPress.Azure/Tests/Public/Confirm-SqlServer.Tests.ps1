BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-SqlServer.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-SqlServer" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
    }

    It "Calls Get-AzSqlServer" {
      Mock Get-AzSqlServer{}
      Confirm-SqlServer -ServerName "sn" -ResourceGroupName "rgn"
      Should -Invoke -CommandName "Get-AzSqlServer" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
