BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-DataFactory.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-DataFactory" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzDataFactoryV2{}
    }

    It "Calls Get-AzDataFactory" {
      Confirm-DataFactory -Name "adf" -ResourceGroupName "rgn"
      Should -Invoke -CommandName "Get-AzDataFactoryV2" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
