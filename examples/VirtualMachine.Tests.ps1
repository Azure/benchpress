BeforeAll {
    Import-Module "../BenchPress/Helpers/BenchPress.Azure/BenchPress.Azure.psd1"
}

Describe 'Verify Virtual Machine' {
    it 'Should contain a Virtual Machine with the given name' {
        #arrange
        $rgName = 'rg-test'
        $vmName = 'vmtest1'
        
        #act
        $exists = Get-AzBPSqlServerExist -ResourceGroupName $rgName -VirtualMachineName $vmName

        #assert
        $exists | Should -Not -BeNullOrEmpty
    }
}

Describe 'Verify Virtual Machine Exists' {
    it 'Should contain a Virtual Machine with the given name' {
        #arrange
        $rgName = 'rg-test'
        $vmName = 'vmtest1'
        
        #act
        $exists = Get-AzBPVirtualMachineExist -ResourceGroupName $rgName -VirtualMachineName $vmName

        #assert
        $exists | Should -Be $true
    }
}

Describe 'Spin up , Tear down a Virtual Machine' {
    it 'Should deploy a bicep file.' {
      #arrange
      $resourceGroupName = "rg-test"
      $bicepPath = "./virtualmachine.bicep"
      $params = @{
        name           = "vmtest2"
        location       = "westus2"
      }
  
      #act
      $deployment = Deploy-AzBPBicepFeature -BicepPath $bicepPath -Params $params -ResourceGroupName $resourceGroupName
  
      #assert
      $deployment.ProvisioningState | Should -Be "Succeeded"
  
      #clean up
      Remove-AzBPBicepFeature -ResourceGroupName $resourceGroupName
    }
}
