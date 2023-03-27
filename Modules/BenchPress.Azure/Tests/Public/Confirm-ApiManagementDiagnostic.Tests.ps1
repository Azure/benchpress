BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-ApiManagementDiagnostic.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-ApiManagementDiagnostic" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzApiManagementDiagnostic{}
      Mock New-AzApiManagementContext{
        New-MockObject -Type 'Microsoft.Azure.Commands.ApiManagement.ServiceManagement.Models.PsApiManagementContext'
      }
    }

    It "Calls Get-AzApiManagementDiagnostic" {
      Confirm-ApiManagementDiagnostic -ResourceGroupName "rgn" -ServiceName "sn" -ApiId "apiid" -Name "diag"
      Should -Invoke -CommandName "Get-AzApiManagementDiagnostic" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
