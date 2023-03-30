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

  It "Should contain a Virtual Machine named $vmName - Confirm-AzBPResource" {
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

  It "Should contain a Virtual Machine named $vmName" {
    #act
    $result = Confirm-AzBPVirtualMachine -ResourceGroupName $rgName -VirtualMachineName $vmName

    #assert
    $result.Success | Should -Be $true
  }

  It "Should not contain a Virtual Machine named $noVmName" {
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
    $result = Confirm-AzBPVirtualMachine @params

    #assert
    $result.Success | Should -Be $false
  }

  It "Should contain a Virtual Machine named $vmName" {
    #act
    $result = Confirm-AzBPVirtualMachine -ResourceGroupName $rgName -VirtualMachineName $vmName

    #assert
    $result | Should -BeDeployed
  }

  It "Should contain a Virtual Machine named $vmName in $location" {
    #act
    $result = Confirm-AzBPVirtualMachine -ResourceGroupName $rgName -VirtualMachineName $vmName

    #assert
    $result | Should -BeInLocation $location
  }

  It "Should contain an Virtual Machine named $vmName in $rgName" {
    #act
    $result = Confirm-AzBPVirtualMachine -ResourceGroupName $rgName -VirtualMachineName $vmName

    #assert
    $result | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
