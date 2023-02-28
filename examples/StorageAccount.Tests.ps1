BeforeAll {
    Import-Module "../BenchPress/Helpers/BenchPress.Azure/BenchPress.Azure.psd1"
}

Describe 'Verify Storage Account Exists' {
    it 'Should contain a Storage Account with the given name' {
        #arrange
        $rgName = 'rg-test'
        $name = 'azbenchpressstorage'

        #act
        $result = Confirm-AzBPStorageAccount -ResourceGroupName $rgName -Name $name

        #assert
        $result.Success | Should -Be $true
    }
}

Describe 'Verify Storage Account Does Not Exist' {
    it 'Should not contain a Storage Account with the given name' {
        #arrange
        $rgName = 'rg-test'
        $name = 'azbenchpressstorage'

        #act
        # The '-ErrorAction SilentlyContinue' command suppresses all errors.
        # In this test, it will suppress the error message when a resource cannot be found.
        # Remove this field to see all errors.
        $result = Confirm-AzBPStorageAccount -ResourceGroupName $rgName -Name $name -ErrorAction SilentlyContinue

        #assert
        $result.Success | Should -Be $false
    }
}

Describe 'Spin up , Tear down a Storage Account' {
    it 'Should deploy a bicep file.' {
      #arrange
      $resourceGroupName = "rg-test"
      $bicepPath = "./storageAccount.bicep"
      $params = @{
        name           = "azbenchpressstorage"
        location       = "westus3"
      }

      #act
      $deployment = Deploy-AzBPBicepFeature -BicepPath $bicepPath -Params $params -ResourceGroupName $resourceGroupName

      #assert
      $deployment.ProvisioningState | Should -Be "Succeeded"

      #clean up
      Remove-AzBPBicepFeature -ResourceGroupName $resourceGroupName
    }
}
