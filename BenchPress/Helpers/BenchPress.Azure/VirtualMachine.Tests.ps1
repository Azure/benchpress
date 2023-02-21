using module ./public/classes/ConfirmResult.psm1

BeforeAll {
  Import-Module $PSScriptRoot/Authentication.psm1
  Import-Module $PSScriptRoot/VirtualMachine.psm1
  Import-Module Az
}

Describe "Confirm-VirtualMachine" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName VirtualMachine Connect-Account{}
    }

    It "Calls Get-AzVM" {
      Mock -ModuleName VirtualMachine Get-AzVM{}
      Confirm-VirtualMachine -VirtualMachineName "vmn" -ResourceGroupName "rgn"
      Should -Invoke -ModuleName VirtualMachine -CommandName "Get-AzVM" -Times 1
    }

    It "Sets the ErrorRecord when an exception is thrown" {
      Mock -ModuleName VirtualMachine Get-AzVM{ throw [Exception]::new("Exception") }
      $Results = Confirm-VirtualMachine -VirtualMachineName "vmn" -ResourceGroupName "rgn"
      $Results.ErrorRecord | Should -Not -Be $null
    }
  }
}

AfterAll {
  Remove-Module Authentication
  Remove-Module VirtualMachine
  Remove-Module Az
}
