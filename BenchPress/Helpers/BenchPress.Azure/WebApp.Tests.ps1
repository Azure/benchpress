BeforeAll {
  Import-Module $PSScriptRoot/WebApp.psm1
  Import-Module Az
}

Describe "Get-WebApp" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName WebApp Get-AzWebApp{}
    }

    It "Calls Get-AzWebApp" {
      Get-WebApp -WebAppName "wan" -ResourceGroupName "rgn"
      Should -Invoke -ModuleName WebApp -CommandName "Get-AzWebApp" -Times 1
    }
  }
}

Describe "Get-WebAppExist" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName WebApp Get-WebApp{}
    }

    It "Calls Get-WebApp" {
      Get-WebAppExist -WebAppName "wan" -ResourceGroupName "rgn"
      Should -Invoke -ModuleName WebApp -CommandName "Get-WebApp" -Times 1
    }
  }
}

AfterAll {
  Remove-Module WebApp
}



