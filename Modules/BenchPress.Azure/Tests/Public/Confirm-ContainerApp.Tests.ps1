BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-ContainerApp.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-ContainerApp" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzContainerApp{}
    }

    It "Calls Get-AzContainerApp" {
      Confirm-ContainerApp -Name "ca" -ResourceGroupName "rgn"
      Should -Invoke -CommandName "Get-AzContainerApp" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
