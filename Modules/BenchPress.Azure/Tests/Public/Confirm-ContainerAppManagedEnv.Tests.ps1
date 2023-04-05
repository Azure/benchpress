BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-ContainerAppManagedEnv.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-ContainerAppManagedEnv" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
      Mock Get-AzContainerAppManagedEnv{}
    }

    It "Calls Get-AzContainerAppManagedEnv" {
      Confirm-ContainerAppManagedEnv -Name "me" -ResourceGroupName "rgn"
      Should -Invoke -CommandName "Get-AzContainerAppManagedEnv" -Times 1
    }
  }
}

AfterAll {
  Remove-Module Az
}
