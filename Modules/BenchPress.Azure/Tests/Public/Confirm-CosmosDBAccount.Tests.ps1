BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-CosmosDBAccount.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-CosmosDBAccount" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
    }

    It "Calls Get-AzCosmosDBAccount" {
      Mock Get-AzCosmosDBAccount{}
      Confirm-CosmosDBAccount -ResourceGroupName "rgn" -Name "cdba"
      Should -Invoke -CommandName "Get-AzCosmosDBAccount" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
