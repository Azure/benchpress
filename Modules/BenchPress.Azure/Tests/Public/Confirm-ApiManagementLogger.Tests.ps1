BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-ApiManagementLogger.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-ApiManagementLogger" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzApiManagementLogger{}
      Mock New-AzApiManagementContext{
        New-MockObject -Type 'Microsoft.Azure.Commands.ApiManagement.ServiceManagement.Models.PsApiManagementContext'
      }
    }

    It "Calls Get-AzApiManagementLogger" {
      Confirm-ApiManagementLogger -ResourceGroupName "rgn" -ServiceName "sn" -Name "logger"
      Should -Invoke -CommandName "Get-AzApiManagementLogger" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
