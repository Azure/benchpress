BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-ApiManagementApi.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-ApiManagementApi" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzApiManagementApi{}
      Mock New-AzApiManagementContext{
        New-MockObject -Type 'Microsoft.Azure.Commands.ApiManagement.ServiceManagement.Models.PsApiManagementContext'
      }
    }

    It "Calls Get-AzApiManagementApi" {
      Confirm-ApiManagementApi -ResourceGroupName "rgn" -ServiceName "sn" -Name "api"
      Should -Invoke -CommandName "Get-AzApiManagementApi" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
