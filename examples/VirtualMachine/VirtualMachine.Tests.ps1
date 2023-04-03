BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:vmName = 'simpleLinuxVM1'
  $Script:location = 'westus3'
}

Describe 'Verify Virtual Machine' {
  BeforeAll {
    $Script:noVmName = 'noSimpleLinuxVM1'
  }

  It 'Should contain a Virtual Machine with the given name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType = "VirtualMachine"
      ResourceGroupName = $rgName
      ResourceName = $vmName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Virtual Machine named $vmName - ConfirmAzBPResource" {
    #arrange
    $params = @{
      ResourceType = "VirtualMachine"
      ResourceGroupName = $rgName
      ResourceName = $vmName
      PropertyKey = 'Name'
      PropertyValue = $vmName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Virtual Machine named $vmName" {
    Confirm-AzBPVirtualMachine -ResourceGroupName $rgName -VirtualMachineName $vmName | Should -BeSuccessful
  }

  It 'Should not contain a Virtual Machine with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      VirtualMachineName = $noVmName
      ErrorAction = "SilentlyContinue"
    }

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    Confirm-AzBPVirtualMachine @params | Should -Not -BeSuccessful
  }

  It "Should contain an Virtual Machine named $vmName in $location" {
    Confirm-AzBPVirtualMachine -ResourceGroupName $rgName -VirtualMachineName $vmName | Should -BeInLocation $location
  }

  It "Should be a Virtual Machine in a resource group named $rgName" {
    Confirm-AzBPVirtualMachine -ResourceGroupName $rgName -VirtualMachineName $vmName
    | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
