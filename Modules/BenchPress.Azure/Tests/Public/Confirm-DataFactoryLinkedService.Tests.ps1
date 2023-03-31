BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-DataFactoryLinkedService.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-DataFactoryLinkedService" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzDataFactoryV2LinkedService{}
    }

    It "Calls Get-AzDataFactoryLinkedService" {
      Confirm-DataFactoryLinkedService -Name "ls" -DataFactoryName "adf" -ResourceGroupName "rgn"
      Should -Invoke -CommandName "Get-AzDataFactoryV2LinkedService" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
