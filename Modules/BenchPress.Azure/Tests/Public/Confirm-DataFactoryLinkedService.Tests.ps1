BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-DataFactoryLinkedService.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-DataFactoryLinkedService" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
    }

    It "Calls Get-AzDataFactoryLinkedService" {
      Mock Get-AzDataFactoryLinkedService{}
      Confirm-DataFactoryLinkedService -Name "ls" -DataFactoryName "adf" -ResourceGroupName "rgn"
      Should -Invoke -CommandName "Get-AzDataFactoryLinkedService" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
