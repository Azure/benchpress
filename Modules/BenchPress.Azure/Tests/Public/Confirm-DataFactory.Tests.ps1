BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-DataFactory.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-DataFactory" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
    }

    It "Calls Get-AzDataFactory" {
      Mock Get-AzDataFactory{}
      Confirm-DataFactory -Name "adf" -ResourceGroupName "rgn"
      Should -Invoke -CommandName "Get-AzDataFactory" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
