# PowerShell How To Test Example

Following instructions shows how to run StorageAccount.Tests.ps1 test.

`StorageAccount.Test.ps1`:

- Deploys Azure resources to the Azure Cloud
- tests deployed resource properties
- Finally deletes deployed resources.

## Prerequisites

- Azure Subscription
- Azure CLI
- Pester [Pester Install Guide](https://pester.dev/docs/introduction/installation)
- Optional: Docker

Test files are located under the following directory: `/samples/dotnet/samples/pwsh/Test`

## Step by Step Guide

### Auth to Azure

Login to Azure Subscription `Connect-AzAccount` from Azure CLI
if you are using docker container `Connect-AzAccount -UseDeviceAuthentication` and follow additional login instructions prompted by terminal

### Running the Test

Storage Account deployment uses two bicep files:

- `storageAccountDeploy.bicep` - to deploy resource group and storage account module. This is an actual deployment file
- `storageAccount.bicep` - storage account bicep file which is called by `storageAccountDeploy.bicep` as a module file

To run the test simply navigate to the `StorageAccount.Tests.ps1` in CLI and execute the PowerShell test file `.\StorageAccount.Tests.ps1`

`StorageAccount.Tests.ps1` - Content.

```powershell
#repo root path
$ROOT_PATH = $PSScriptRoot | split-path -parent | split-path -parent | split-path -parent | split-path -parent | split-path -parent

BeforeAll {
    Import-Module -Name $ROOT_PATH/BenchPress/Helpers/Azure/StorageAcccount.psm1
    Import-Module -Name $ROOT_PATH/BenchPress/Helpers/Azure/Bicep.psm1
}

#global variables with required values for the tests. script keyword is used to avoid powershell megalinter complain for global keyword
$script:storageAccountName = 'mystnamebicepv2'
$script:resourceGroupName = 'rg-test-bicep'

Describe 'Spin up , Tear down Storage Account' {
    it 'Should deploy a bicep file.' {

      #bicep file path
      $bicepPath = "$ROOT_PATH/samples/dotnet/samples/pwsh/storageAccountDeploy.bicep"

      #required parameters for storage account deployment
      $params = @{
        resourceGroupName = "rg-test-bicep"
        location = "eastus"
        storageName = "mystnamebicepv2"
      }

      #Calling Deploy-BicepFeature helper to deploy resources
      $deployment = Deploy-BicepFeature $bicepPath $params

      #checking the return state from deployment
      $deployment.ProvisioningState | Should -Be 'Succeeded'
    }

    it 'Should check storage account exist' {
      #Calling StorageAccount helper method to check expected storage account exist
      $storageAccount = Get-StorageAccountExists $resourceGroupName $storageAccountName

      #assert return value from StorageAccount helper
      $storageAccount | Should -Not -BeNullOrEmpty -ErrorAction Stop
    }

    it 'Should Check Storage Sku Name'{

      #Calling StorageAccount helper method to check for expected storage Sku
      $getStorageAccountSku = Get-StorageAccountSku $resourceGroupName $storageAccountName

      #assert return value from StorageAccount helper
      $getStorageAccountSku | Should -Be "Standard_LRS"
    }

    it 'Should Check Storage Kind'{
      #Calling StorageAccount helper method to check for expected storage Kind
      $getStorageAccountKind = Get-StorageAccountKind $resourceGroupName $storageAccountName

      #assert return value from StorageAccount helper
      $getStorageAccountKind | Should -Be "StorageV2"
    }

    it 'Delete Deployed Resources'{
      #Call Bicep helper to remove deployed resources
      Remove-BicepFeature $resourceGroupName
    }
}
```
