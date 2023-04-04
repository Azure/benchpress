BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-EventHub.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-EventHub" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzEventHub{}
    }

    It "Calls Get-AzEventHub" {
      Confirm-EventHub -Name "EventHub" -NamespaceName "Namespace" -ResourceGroupName "rgn"
      Should -Invoke -CommandName "Get-AzEventHub" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
