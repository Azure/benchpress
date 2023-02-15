BeforeAll {
  Import-Module $PSScriptRoot/Authentication.psm1
  Import-Module $PSScriptRoot/SqlServer.psm1
  Import-Module Az
}

Describe "Get-SqlServer" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName SqlServer Connect-Account{}
      Mock -ModuleName SqlServer Get-AzSqlServer{}
    }

    It "Calls Get-AzSqlServer" {
      Get-SqlServer -ServerName "sn" -ResourceGroupName "rgn"
      Should -Invoke -ModuleName SqlServer -CommandName "Get-AzSqlServer" -Times 1
    }
  }
}

Describe "Get-SqlServerExist" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName SqlServer Get-SqlServer{}
    }

    It "Calls Get-SqlServer" {
      Get-SqlServerExist -ServerName "sn" -ResourceGroupName "rgn"
      Should -Invoke -ModuleName SqlServer -CommandName "Get-SqlServer" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Authentication
  Remove-Module SqlServer
}
