BeforeAll {
  Import-Module $PSScriptRoot/AppServicePlan.psm1
  Import-Module Az
}

Describe "Get-AppServicePlan" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName AppServicePlan Get-AzAppServicePlan{}
    }

    It "Calls Get-AzAppServicePlan" {
      Get-AppServicePlan -AppServicePlanName "aspn" -ResourceGroupName "rgn"
      Should -Invoke -ModuleName AppServicePlan -CommandName "Get-AzAppServicePlan" -Times 1
    }
  }
}

Describe "Get-AppServicePlanExist" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName AppServicePlan Get-AppServicePlan{}
    }

    It "Calls Get-AppServicePlan" {
      Get-AppServicePlanExist -AppServicePlanName "aspn" -ResourceGroupName "rgn"
      Should -Invoke -ModuleName AppServicePlan -CommandName "Get-AppServicePlan" -Times 1
    }
  }
}

AfterAll {
  Remove-Module AppServicePlan
}
