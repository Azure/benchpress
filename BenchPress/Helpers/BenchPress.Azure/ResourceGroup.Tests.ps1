BeforeAll {
  Import-Module $PSScriptRoot/Authentication.psm1
  Import-Module $PSScriptRoot/ResourceGroup.psm1
  Import-Module Az
}

Describe "Get-ResourceGroup" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName ResourceGroup Connect-Account{}
      Mock -ModuleName ResourceGroup Get-AzResourceGroup{}
    }

    It "Calls Get-AzResourceGroup" {
      Get-ResourceGroup -ResourceGroupName "rgn"
      Should -Invoke -ModuleName ResourceGroup -CommandName "Get-AzResourceGroup" -Times 1
    }
  }
}

Describe "Get-ResourceGroupExist" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName ResourceGroup Get-ResourceGroup{}
    }

    It "Calls Get-ResourceGroup" {
      Get-ResourceGroupExist -ResourceGroupName "rgn"
      Should -Invoke -ModuleName ResourceGroup -CommandName "Get-ResourceGroup" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Authentication
  Remove-Module ResourceGroup
}
