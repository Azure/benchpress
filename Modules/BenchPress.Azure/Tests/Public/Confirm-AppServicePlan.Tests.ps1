BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-AppServicePlan.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-AppServicePlan" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzAppServicePlan{}
    }

    It "Calls Get-AzAppServicePlan" {
      Mock Get-AzAppServicePlan{}
      Confirm-AppServicePlan -AppServicePlanName "aspn" -ResourceGroupName "rgn"
      Should -Invoke -CommandName "Get-AzAppServicePlan" -Times 1
    }

    It "Sets the ErrorRecord when an exception is thrown" {
      Mock Get-AzAppServicePlan{ throw [Exception]::new("Exception") }
      $Results = Confirm-AppServicePlan -AppServicePlanName "aspn" -ResourceGroupName "rgn"
      $Results.ErrorRecord | Should -Not -Be $null
    }
  }
}

AfterAll {
  Remove-Module Az
}
