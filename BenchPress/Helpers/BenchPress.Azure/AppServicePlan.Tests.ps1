using module ./public/classes/ConfirmResult.psm1

BeforeAll {
  Import-Module $PSScriptRoot/AppServicePlan.psm1
  Import-Module $PSScriptRoot/Authentication.psm1
  Import-Module Az
}

Describe "Confirm-AppServicePlan" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName AppServicePlan Connect-Account{}
      Mock -ModuleName AppServicePlan Get-AzAppServicePlan{}
    }

    It "Calls Get-AzAppServicePlan" {
      Mock -ModuleName AppServicePlan Get-AzAppServicePlan{}
      Confirm-AppServicePlan -AppServicePlanName "aspn" -ResourceGroupName "rgn"
      Should -Invoke -ModuleName AppServicePlan -CommandName "Get-AzAppServicePlan" -Times 1
    }

    It "Sets the ErrorRecord when an exception is thrown" {
      Mock -ModuleName AppServicePlan Get-AzAppServicePlan{ throw [Exception]::new("Exception") }
      $Results = Confirm-AppServicePlan -AppServicePlanName "aspn" -ResourceGroupName "rgn"
      $Results.ErrorRecord | Should -Not -Be $null
    }
  }
}

AfterAll {
  Remove-Module AppServicePlan
  Remove-Module Authentication
  Remove-Module Az
}
