BeforeAll {
    Import-Module "../BenchPress/Helpers/BenchPress.Azure/BenchPress.Azure.psd1"
}

Describe 'Verify Virtual Machine Exists' {
    it 'Should contain a Virtual Machine with the given name' {
        #arrange
        $rgName = 'rg-test'
        $vmName = 'simpleLinuxVM1'

        #act
        $result = Confirm-AzBPVirtualMachine -ResourceGroupName $rgName -VirtualMachineName $vmName

        #assert
        $result.Success | Should -Be $true
    }
}

Describe 'Verify Virtual Machine Does Not Exist' {
    it 'Should not contain a Virtual Machine with the given name' {
        #arrange
        $rgName = 'rg-test'
        $vmName = 'simpleLinuxVM1'

        #act
        # The '-ErrorAction SilentlyContinue' command suppresses all errors.
        # In this test, it will suppress the error message when a resource cannot be found.
        # Remove this field to see all errors.
        $result = Confirm-AzBPVirtualMachine -ResourceGroupName $rgName -VirtualMachineName $vmName -ErrorAction SilentlyContinue

        #assert
        $result.Success | Should -Be $false
    }
}

Describe 'Spin up , Tear down a Virtual Machine' {
    it 'Should deploy a bicep file.' {
      #arrange
      $resourceGroupName = "rg-test2"
      $bicepPath = "./virtualmachine.bicep"
      $params = @{
        vmName             = "simpleLinuxVM2"
        location           = "westus3"
        adminPasswordOrKey = "<sample-password>"
      }

      #act
      $deployment = Deploy-AzBPBicepFeature -BicepPath $bicepPath -Params $params -ResourceGroupName $resourceGroupName

      #assert
      $deployment.ProvisioningState | Should -Be "Succeeded"

      #clean up
      Remove-AzBPBicepFeature -ResourceGroupName $resourceGroupName
    }
}
