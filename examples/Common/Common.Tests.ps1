BeforeAll {
  Import-Module Az-InfrastructureTest
}

Describe 'Verify Resource Exists' {
  it 'should have a resource group called rg-test' {
    #arrange
    $rgName = "rg-test"

    #act
    $result = Get-AzBPResourceByType -ResourceType ResourceGroup -ResourceName "${rgName}"

    #assert
    $result.Success | Should -Be $true
  }

  it 'should have a virtual machine named testvm' {
    #arrange
    $resourceName = "testvm"
    $rgName = "rg-test"

    #act
    $result = Get-AzBPResourceByType -ResourceType VirtualMachine -ResourceName "${resourceName}" -ResourceGroupName "${rgName}"

    #assert
    $result.Success | Should -Be $true
  }

  it 'should have a resource with name of testvm' {
    #arrange
    $resourceName = "testvm"

    #act
    $exists = Get-AzBPResource -ResourceName "${resourceName}"

    #assert
    $exists | Should -Not -Be $null
  }
}

Describe 'Use Confirm-AzBPResource to confirm resource and/or properties exist'{
  Describe 'Verify Container Registry' {
    it 'Should contain a container registry named testcontaineregistry' {
      #arrange
      $resourceGroupName = "rg-test"
      $resourceType = "ContainerRegistry"
      $containerRegistryName = "testcontaineregistry"

      #act
      $result = Confirm-AzBPResource -ResourceGroupName $resourceGroupName -ResourceType $ResourceType `
                  -ResourceName $containerRegistryName

      #assert
      $result.Success | Should -Be $true
    }

    it 'Should contain a container registry named testcontaineregistry is Standard' {
      #arrange
      $resourceGroupName = "rg-test"
      $resourceType = "ContainerRegistry"
      $containerRegistryName = "testcontaineregistry"
      $property = "SkuName"
      $expectedValue = "Standard"

      #act
      $result = Confirm-AzBPResource -ResourceGroupName $resourceGroupName -ResourceType $ResourceType `
                  -ResourceName $containerRegistryName -PropertyKey $property -PropertyValue $expectedValue

      #assert
      $result.Success | Should -Be $true
    }
  }

  Describe 'Verify Resource Group' {
    it 'Should contain a resource group named rg-test' {
      #arrange
      $resourceGroupName = "rg-test"
      $resourceType = "ResourceGroup"

      #act
      $result = Confirm-AzBPResource -ResourceType $resourceType -ResourceName $resourceGroupName

      #assert
      $result.Success | Should -Be $true
    }

    it 'Should contain a resource group named rg-test in WestUS3' {
      #arrange
      $resourceGroupName = "rg-test"
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
        ResourceGroupName = "rg-test";
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
        ResourceGroupName = "rg-test";
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
        ResourceGroupName = "rg-test";
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
    it 'Should not contain a VM named notestvm' {
      #arrange
      $resourceGroupName = "rg-test"
      $resourceType = "VirtualMachine"
      $resourceName = "notestvm"

      #act
      # The '-ErrorAction SilentlyContinue' command suppresses all errors.
      # In this test, it will suppress the error message when a resource cannot be found.
      # Remove this field to see all errors.
      $result = Confirm-AzBPResource -ResourceType $resourceType -ResourceName $resourceName `
                  -ResourceGroupName $resourceGroupName -ErrorAction SilentlyContinue

      #assert
      $result.Success | Should -Be $false
    }
  }

  Describe 'Verify Key Vault' {
    it 'Should contain a key vault named testkv' {
      #arrange
      $params = @{
        ResourceGroupName = "rg-test";
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
        ResourceGroupName = "rg-test";
        ResourceType = "KeyVault";
        ResourceName = "testkv";
        PropertyKey = "AccessPolicies[0].DisplayName";
        PropertyValue = "testsp (<your-testsp-appid>)"
      }
      #act
      $result = Confirm-AzBPResource @params

      #assert
      $result.Success | Should -Be $true
    }
  }
}
