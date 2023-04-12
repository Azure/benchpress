BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-EventHubNamespace.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-EventHubNamespace" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzEventHubNamespace{}
    }

    It "Calls Get-AzEventHubNamespace" {
      Confirm-EventHubNamespace -NamespaceName "EventHubNamespace" -ResourceGroupName "rgn"
      Should -Invoke -CommandName "Get-AzEventHubNamespace" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
