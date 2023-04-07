BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-DiagnosticSetting.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-DiagnosticSetting" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzDiagnosticSetting{}
    }

    It "Calls Get-AzDiagnosticSetting" {
      Confirm-DiagnosticSetting -ResourceId "testresourceId" -Name "dgName"
      Should -Invoke -CommandName "Get-AzDiagnosticSetting" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
