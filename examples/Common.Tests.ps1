BeforeAll {
  Import-Module "../BenchPress/Helpers/BenchPress.Azure/BenchPress.Azure.psd1"
}

Describe 'Verify Resource Exists' {
  it 'should has a resource with type of ResourceGroup and name of AzurePortal' {
    #arrange
    $rgName = "AzurePortal"

    #act
    $exists = Get-AzBPResourceByType -ResourceType ResourceGroup -ResourceName "${rgName}"

    #assert
    $exists | Should -Be $true
  }

  it 'should has a resource with type of VirtualMachine and name of testVM' {
    #arrange
    $resourceName = "testVM"
    $rgName = "AzurePortal"

    #act
    $exists = Get-AzBPResourceByType -ResourceType VirtualMachine -ResourceName "${resourceName}" -ResourceGroupName "${rgName}"

    #assert
    $exists | Should -Be $true
  }

  it 'should has a resource with name of AzurePortal' {
    #arrange
    $resourceName = "testVM"

    #act
    $exists = Get-AzBPResource -ResourceName "${resourceName}"

    #assert
    $exists | Should -Be $true
  }

  it 'should has a resource with name of testVM' {
    #arrange
    $resourceName = "testVM"

    #act
    $exists = Get-AzBPResource -ResourceName "${resourceName}"

    #assert
    $exists | Should -Be $true
  }
}

Describe 'Use Confirm-AzBPResource to confirm resource and/or properties exist'{
  Describe 'Verify Container Registry' {
    it 'Should contain a container registry named testcontaineregistry' {
      #arrange
      $resourceGroupName = "testrg"
      $resourceType = "ContainerRegistry"
      $containerRegistryName = "testcontaineregistry"

      #act
      $result = Confirm-AzBPResource -ResourceGroupName $resourceGroupName -ResourceType $resourceType `
                  -ResourceName $containerRegistryName

      #assert
      $result.Success | Should -Be $true
    }

    it 'Should contain a container registry named testcontaineregistry is Standard' {
      #arrange
      $resourceGroupName = "testrg"
      $resourceType = "ContainerRegistry"
      $containerRegistryName = "testcontaineregistry"
      $property = "SkuName"
      $expectedValue = "Standard"

      #act
      $result = Confirm-AzBPResource -ResourceGroupName $resourceGroupName -ResourceType $resourceType `
                  -ResourceName $containerRegistryName -PropertyKey $property -PropertyValue $expectedValue

      #assert
      $result.Success | Should -Be $true
    }
  }

  Describe 'Verify Resource Group' {
    it 'Should contain a resource group named testrg' {
      #arrange
      $resourceGroupName = "testrg"
      $resourceType = "ResourceGroup"

      #act
      $result = Confirm-AzBPResource -ResourceType $resourceType -ResourceName $resourceGroupName

      #assert
      $result.Success | Should -Be $true
    }

    it 'Should contain a resource group named testrg in WestUS3' {
      #arrange
      $resourceGroupName = "testrg"
      $resourceType = "ResourceGroup"
      $property = "Location"
      $expectedValue = "WestUS3"

      #act
      $result = Confirm-AzBPResource -ResourceType $resourceType -ResourceName $resourceGroupName `
                  -PropertyKey $property -PropertyValue $expectedValue

      #assert
      $result.Success | Should -Be $true
    }
  }

  Describe 'Verify SQL Server and DB' {
    it 'Should contain a SQL Server named testserver' {
      #arrange
      $params = @{
        ResourceGroupName = "testrg";
        ResourceType = "SqlServer";
        ResourceName = "testserver"
      }
      #act
      $result = Confirm-AzBPResource @params

      #assert
      $result.Success | Should -Be $true
    }
    it 'Should contain a SQL Server named testserver with a Sql Database named testdb' {
      #arrange
      $params = @{
        ResourceGroupName = "testrg";
        ResourceType = "SqlDatabase";
        ServerName = "testserver";
        ResourceName = "testdb"
      }
      #act
      $result = Confirm-AzBPResource @params

      #assert
      $result.Success | Should -Be $true
    }
  }
  Describe 'Verify VM' {
    it 'Should contain a VM named testvm with OSType Linux' {
      #arrange
      $params = @{
        ResourceGroupName = "testrg";
        ResourceType = "VirtualMachine";
        ResourceName = "testvm";
        PropertyKey = "StorageProfile.OsDisk.OsType";
        PropertyValue = "Linux"
      }
      #act
      $result = Confirm-AzBPResource @params

      #assert
      $result.Success | Should -Be $true
    }
  }

  Describe 'Verify Key Vault' {
    it 'Should contain a key vault named testkv' {
      #arrange
      $params = @{
        ResourceGroupName = "testrg";
        ResourceType = "KeyVault";
        ResourceName = "testkv";
      }
      #act
      $result = Confirm-AzBPResource @params

      #assert
      $result.Success | Should -Be $true
    }

    it 'Should contain a key vault named testkv with an access policy for testsp service principal' {
      #arrange
      $params = @{
        ResourceGroupName = "testrg";
        ResourceType = "KeyVault";
        ResourceName = "testkv";
        PropertyKey = "AccessPolicies[1].DisplayName";
        PropertyValue = "testsp (<your-testsp-appid>)"
      }
      #act
      $result = Confirm-AzBPResource @params

      #assert
      $result.Success | Should -Be $true
    }
  }
}

Describe 'Verify Resource Group Does Not Exist' {
  it 'Should not contain a resource group named testrg2' {
    #arrange
    $resourceGroupName = "testrg2"
    $resourceType = "ResourceGroup"

    #act
    #This will throw an error
    $result = Confirm-AzBPResource -ResourceType $resourceType -ResourceName $resourceGroupName

    #assert
    $result.Success | Should -Be $false
  }

  it 'Should not contain a resource group named testrg in WestUS2' {
    #arrange
    $resourceGroupName = "testrg"
    $resourceType = "ResourceGroup"
    $property = "Location"
    $expectedValue = "WestUS2"

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPResource -ResourceType $resourceType -ResourceName $resourceGroupName `
                -PropertyKey $property -PropertyValue $expectedValue -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }
}
