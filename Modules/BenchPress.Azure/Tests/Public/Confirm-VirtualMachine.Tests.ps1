BeforeAll {
  . $PSScriptRoot/../../Public/Confirm-VirtualMachine.ps1
  . $PSScriptRoot/../../Private/Connect-Account.ps1
  Import-Module Az
}

Describe "Confirm-VirtualMachine" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock Connect-Account{}
    }

    It "Calls Get-AzVM" {
      Mock Get-AzVM{}
      Confirm-VirtualMachine -VirtualMachineName "vmn" -ResourceGroupName "rgn"
      Should -Invoke -CommandName "Get-AzVM" -Times 1
    }

    It "Sets the ErrorRecord when an exception is thrown" {
      Mock Get-AzVM{ throw [Exception]::new("Exception") }
      $Results = Confirm-VirtualMachine -VirtualMachineName "vmn" -ResourceGroupName "rgn"
      $Results.ErrorRecord | Should -Not -Be $null
    }
  }
}

AfterAll {
  Remove-Module Az
}
