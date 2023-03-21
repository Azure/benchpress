BeforeAll {
  Import-Module Az.InfrastructureTesting

  $rgName = 'rg-test'
  $vmName = 'simpleLinuxVM1'
  $location = 'westus3'
}

Describe 'Verify Virtual Machine' {
  It 'Should contain a Virtual Machine with the given name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType = "VirtualMachine"
      ResourceGroupName = $rgName
      ResourceName = $vmName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
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
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should contain a Virtual Machine with the given name' {
    #act
    $result = Confirm-AzBPVirtualMachine -ResourceGroupName $rgName -VirtualMachineName $vmName

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should not contain a Virtual Machine with the given name' {
    #arrange
    $params = @{
      ResourceGroupName = $rgName
      VirtualMachineName = 'noSimpleLinuxVM1'
      ErrorAction = "SilentlyContinue"
    }

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPVirtualMachine @params

    #assert
    $result.Success | Should -Be $false
  }

  It 'Should contain a Virtual Machine named simpleLinuxVM1' {
    #act
    $result = Confirm-AzBPVirtualMachine -ResourceGroupName $rgName -VirtualMachineName $vmName

    #assert
    $result | Should -BeDeployed
  }

  It "Should contain an Virtual Machine named simpleLinuxVM1 in $location" {
    #act
    $result = Confirm-AzBPVirtualMachine -ResourceGroupName $rgName -VirtualMachineName $vmName

    #assert
    $result | Should -BeInLocation $location
  }

  It 'Should be a Virtual Machine in a resource group named rg-test' {
    #act
    $result = Confirm-AzBPVirtualMachine -ResourceGroupName $rgName -VirtualMachineName $vmName

    #assert
    $result | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az-InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
