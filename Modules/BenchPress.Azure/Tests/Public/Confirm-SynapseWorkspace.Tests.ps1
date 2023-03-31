BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-SynapseWorkspace.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-SynapseWorkspace" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzSynapseWorkspace{}
    }

    It "Calls Get-AzSynapseWorkspace" {
      Confirm-SynapseWorkspace -WorkspaceName "syn" -ResourceGroupName "rgn"
      Should -Invoke -CommandName "Get-AzSynapseWorkspace" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
