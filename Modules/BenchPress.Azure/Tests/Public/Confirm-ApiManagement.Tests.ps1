BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-ApiManagement.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-ApiManagement" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
    }

    It "Calls Get-AzApiManagement" {
      Mock Get-AzApiManagement{}
      Confirm-ApiManagement -Name "apim" -ResourceGroupName "rgn"
      Should -Invoke -CommandName "Get-AzApiManagement" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
