BeforeAll {
  Import-Module $PSScriptRoot/VirtualMachine.psm1
  Import-Module Az
}

Describe "Get-VirtualMachine" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName VirtualMachine Get-AzVM{}
    }

    It "Calls Get-AzVM" {
      Get-VirtualMachine -VirtualMachineName "vmn" -ResourceGroupName "rgn"
      Should -Invoke -ModuleName VirtualMachine -CommandName "Get-AzVM" -Times 1
    }
  }
}

Describe "Get-VirtualMachineExist" {
  Context "unit tests" -Tag "Unit" {
    BeforeEach {
      Mock -ModuleName VirtualMachine Get-VirtualMachine{}
    }

    It "Calls Get-VirtualMachine" {
      Get-VirtualMachineExist -VirtualMachineName "vmn" -ResourceGroupName "rgn"
      Should -Invoke -ModuleName VirtualMachine -CommandName "Get-VirtualMachine" -Times 1
    }
  }
}

AfterAll {
  Remove-Module VirtualMachine
}

