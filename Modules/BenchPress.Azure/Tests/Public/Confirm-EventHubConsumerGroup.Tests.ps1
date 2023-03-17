BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-EventHubConsumerGroup.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-EventHubConsumerGroup" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
    }

    It "Calls Get-AzEventHubConsumerGroup" {
      Mock Get-AzEventHubConsumerGroup{}
      $params = @{
        Name              = "consumergroup"
        NamespaceName     = "namespace"
        EventHubName      = "eventhub"
        ResourceGroupName = "rgn"
      }
      Confirm-EventHubConsumerGroup @params
      Should -Invoke -CommandName "Get-AzEventHubConsumerGroup" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
