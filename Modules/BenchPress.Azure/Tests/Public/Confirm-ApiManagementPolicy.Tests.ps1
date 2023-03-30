BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-ApiManagementPolicy.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-ApiManagementPolicy" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzApiManagementPolicy{}
      Mock New-AzApiManagementContext{
        New-MockObject -Type 'Microsoft.Azure.Commands.ApiManagement.ServiceManagement.Models.PsApiManagementContext'
      }
    }

    It "Calls Get-AzApiManagementPolicy" {
      Confirm-ApiManagementPolicy -ResourceGroupName "rgn" -ServiceName "sn" -ApiId "apiid"
      Should -Invoke -CommandName "Get-AzApiManagementPolicy" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
