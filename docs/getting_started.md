# Getting Started with BenchPress

## BenchPress intro

The basic usage pattern for writing automated tests with BenchPress is to:

1. Write tests using [Pester testing framework](https://pester.dev/docs/quick-start). Create test files ending in `Tests.ps1` and run test files using `Invoke-Pester`.
1. Deploy resources to Azure using bicep (or helpers from BenchPress).
1. Use BenchPress to return information about deployed resources.
1. (Optional) Use BenchPress to tear down resources at the end of the test.

## Requirements

BenchPress uses PowerShell and the Azure Az PowerShell module. Users should use Pester as their testing framework and runner. To use BenchPress, have the following installed:

- [PowerShell](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows) (PowerShell 7+ recommended)
- [Az PowerShell module](https://learn.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-9.3.0)
  - [Az.App PowerShell module](https://learn.microsoft.com/en-us/powershell/module/az.app/?view=azps-9.5.0) for any testing of Container Applications. Az.App is not GA yet which is why it is not included with the main Az PowerShell module.
  - [Az.Portal PowerShell module](https://learn.microsoft.com/en-us/powershell/module/az.app/?view=azps-9.5.0) for any testing of Azure Dashboards. Az.Portal is not GA yet which is why it is not included with the main Az PowerShell module.
- [Pester](https://pester.dev/docs/introduction/installation)
- [Bicep](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/install#azure-powershell)
- [Service Principal](https://learn.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal) created for your application.

An Azure subscription that you can deploy resources to is also a requirement.

## Authenticating to Azure

There are two primary mechanisms to authenticate to Azure using BenchPress, either by using an [Application Service Principal](https://learn.microsoft.com/en-us/azure/active-directory/develop/app-objects-and-service-principals?tabs=browser#service-principal-object) or a [Managed Identity](https://learn.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/overview) for Azure environments.

- For Managed Identity:

  Set the following environment variables so that the BenchPress tools can deploy (if necessary), confirm, and destroy (if necessary) resources in the target subscription.

  - `AZ_USE_MANAGED_IDENTITY="true"` - A boolean flag that instructs BenchPress to authenticate using the Managed Identity
  - `AZ_SUBSCRIPTION_ID` - The Subscription ID of the Subscription within the Tenant to access

- For Application Service Principal:

  Set the following environment variables so that the BenchPress tools can deploy (if necessary), confirm, and destroy (if necessary) resources in the target subscription.

  - `AZ_APPLICATION_ID` - The Service Principal's application ID
  - `AZ_TENANT_ID` - The Tenant ID of the Azure Tenant to access
  - `AZ_SUBSCRIPTION_ID` - The Subscription ID of the Subscription within the Tenant to access
  - `AZ_ENCRYPTED_PASSWORD` - The **encrypted** password of the Service Principal. This value must be an encrypted string. It is the responsibility of the user to encrypt the Service Principal password. The following PowerShell code can be used to encrypt the Service Principal password before saving as an environment variable: `<raw password> | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString`. This takes the raw password and converts the password to a SecureString. This SecureString must then be converted to a String. `ConvertFrom-SecureString` will take the SecureString and convert it to an encrypted string. This value must then be saved as an environment variable. This ensures that the BenchPress code never uses the raw password at any point.

  Example command to create a Service Principal is;

  ```powershell
  $AZURE_RBAC = $(az ad sp create-for-rbac --name "BenchPress.Module.Contributor" --role contributor --scopes /subscriptions/$(az account show --query "id" --output "tsv"))
  ```

  You can either use a `.env` file and pass in the environment variables locally with a script, or you must load each variable through the command line using:

  ```PowerShell
  $env:AZ_APPLICATION_ID="<sample-application-id>"
  $env:AZ_TENANT_ID="<sample-tenant-id>"
  $env:AZ_SUBSCRIPTION_ID="<sample-subscription-id>"
  $env:AZ_ENCRYPTED_PASSWORD="<sample-encrypted-password>"
  ```

  Example command to set the environment variables locally is;

  ```powershell
  $env:AZ_SUBSCRIPTION_ID = "$(az account show --query 'id' --output tsv)"
  $env:AZ_TENANT_ID = "$(az account show --query 'tenantId' --output tsv)"
  $env:AZ_APPLICATION_ID = $($AZURE_RBAC | ConvertFrom-Json).appId
  $env:AZ_ENCRYPTED_PASSWORD = $($AZURE_RBAC | ConvertFrom-Json).password | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString
  ```

  You can confirm if these are set up right on your local powershell using:

  ```PowerShell
  [Environment]::GetEnvironmentVariables()
  ```

  > Afterwards, to clean up the Service Principal, you can run the following command:
  >
  > ```powershell
  > az ad sp delete --id $($AZURE_RBAC | ConvertFrom-Json).appId
  > ```

## Setting up your project

The easiest way to get started with BenchPress is to use the files in the `examples` folder.

1. Clone the repository, open a PowerShell terminal, and navigate to the `examples` folder.

1. Follow the [Authenticating to Azure](#authenticating-to-azure) section to set up your environment variables.

1. To run the project locally, follow the [installation guide](./installation.md).

## Running a test file

1. You can use any of the `*.Tests.ps1` for this quickstart, but we will specifically use `containerRegistry.bicep` and `ContainerRegistry.Tests.ps1` as our examples. To run the `ContainerRegistry.Tests.ps1` tests, execute `.\ContainerRegistry.Tests.ps1` or `Invoke-Pester -Path .\ContainerRegistry.Tests.ps1`.

1. Your test results will most likely be 5 test failures, all saying something similar to this:

   ```PowerShell
    Starting discovery in 1 files.
    Discovery found 3 tests in 44ms.
    Running tests.
    Get-AzContainerRegistry: <path>\BenchPress\benchpress\Modules\BenchPress.Azure\Public\Confirm-ContainerRegistry.ps1:44
    Line |
    44 |  … $resource = Get-AzContainerRegistry -ResourceGroupName $ResourceGroup …
     |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     | Resource group 'rg-test' could not be found.
    [-] Verify Container Registry.Should contain a Container Registry named  - Confirm-AzBPResource 847ms (846ms|1ms)
    Resource not deployed or there was an error when confirming resource.
    at Confirm-AzBPResource @params | Should -BeSuccessful, C:\Users\<>\ContainerRegistry.Tests.ps1:23
    .
    .
    .
    Tests completed in 4.05s
    Tests Passed: 1, Failed: 5, Skipped: 0 NotRun: 0
   ```

## Walkthrough of Test File

Let's walkthrough the `ContainerRegistry.Tests.ps1` file to understand how BenchPress is used to test our Infrastructure as Code (IaC) and why our tests are failing.

```PowerShell
BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:acrName = 'acrbenchpresstest'
  $Script:location = 'westus3'
}

Describe 'Verify Container Registry' {
  BeforeAll {
    $Script:noContainerRegistryName = 'nocontainerregistry'
  }

  It "Should contain a Container Registry named $acrName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "ContainerRegistry"
      ResourceName      = $acrName
      ResourceGroupName = $rgName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Container Registry named $acrName with a Standard SKU - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "ContainerRegistry"
      ResourceName      = $acrName
      ResourceGroupName = $rgName
      PropertyKey       = "SkuName"
      PropertyValue     = "Basic"
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Container Registry named $acrName" {
    Confirm-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName | Should -BeSuccessful
  }

  It "Should not contain a Container Registry named $noContainerRegistryName" {
    # arrange
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName     = $rgName
      Name                  = $noContainerRegistryName
      ErrorAction           = "SilentlyContinue"
    }

    # act and assert
    Confirm-AzBPContainerRegistry @params | Should -Not -BeSuccessful
  }

  It "Should contain a Container Registry named $acrName in $location" {
    Confirm-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName | Should -BeInLocation $location
  }

  It "Should contain a Container Registry named $acrName in $rgName" {
    Confirm-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}

```

This test file uses Pester's `Describe` and `It` keywords to represent tests. Each test checks different scenarios: Whether a Container Registry exists, if it's in the correct resource group, and if it has the correct location set. We also import the BenchPress module in the `BeforeAll` block (which looks different depending on if you're running locally - see [installation](./installation.md)).

The first two `It` blocks are similar:

```PowerShell
It "Should contain a Container Registry named $acrName - Confirm-AzBPResource" {
  # arrange
  $params = @{
    ResourceType      = "ContainerRegistry"
    ResourceName      = $acrName
    ResourceGroupName = $rgName
  }

  # act and assert
  Confirm-AzBPResource @params | Should -BeSuccessful
}

It "Should contain a Container Registry named $acrName with a Standard SKU - Confirm-AzBPResource" {
  # arrange
  $params = @{
    ResourceType      = "ContainerRegistry"
    ResourceName      = $acrName
    ResourceGroupName = $rgName
    PropertyKey       = "SkuName"
    PropertyValue     = "Basic"
  }

  # act and assert
  Confirm-AzBPResource @params | Should -BeSuccessful
}
```

This test uses the `Confirm-AzBPResource` helper from BenchPress. `Confirm-AzBPResource` returns a `ConfirmResult` object with information about the success of the call, resource details, authentication data and an error record. Assuming the container registry exists, we assert that the object returned by `Confirm-AzBPResource` is successful.

The second test checks if a specific property key and value exists.

Let's look at the third `It` block:

```PowerShell
It "Should contain a Container Registry named $acrName" {
  Confirm-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName | Should -BeSuccessful
}
```

This test does something very similar to the first test, except it uses the `Confirm-AzBPContainerRegistry` cdmlet.

The last two tests use the same command, but check for resource group and location instead:

```PowerShell
It "Should contain a Container Registry named $acrName in $location" {
  Confirm-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName | Should -BeInLocation $location
}

It "Should contain a Container Registry named $acrName in $rgName" {
  Confirm-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName | Should -BeInResourceGroup $rgName
}
```

The fourth test is a negative test, and interestingly, it's the only test that passes. This is because the resource defined in the file does not exist yet:

```PowerShell
It "Should not contain a Container Registry named $noContainerRegistryName" {
    # arrange
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName     = $rgName
      Name                  = $noContainerRegistryName
      ErrorAction           = "SilentlyContinue"
    }

    # act and assert
    Confirm-AzBPContainerRegistry @params | Should -Not -BeSuccessful
  }
```

Take note of the `-ErrorAction SilentlyContinue` comment.

## Fixing the Tests

Now that we've done a walkthrough of all tests, let's fix them.

Most of the tests assumed that our container registry was already deployed to a resource group. However, we never deployed the `containerRegistry.bicep` file ourselves! Most tests also assumed we had an existing resource group to deploy to, but we never deployed that either! Let's go ahead and fix these assumptions now:

1. Create a resource group in your subscription.
1. Deploy the container registry bicep file to that resource group:

   ```PowerShell
   New-AzResourceGroupDeployment -ResourceGroupName "<your-resource-group-name>" -TemplateFile ".\containerRegistry.bicep"
   ```

   (If you get an error that bicep is not recognized, you may need to [manually install](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/install#azure-powershell) bicep.)

1. Update the `ContainerRegistry.Tests.ps1` file to replace the placeholder values with the actual values from your deployment. Note that when executing `New-AzResourceGroupDeployment` the output will contain the name generated for the new Container Registry.

   `$Script:rgName = '<your-resource-group-name>'`
   `$Script:acrName = '<your-container-registry-name>'`
   `$Script:location = '<your-resource-group-location-name>'`

1. Run your test again! Success!

   ```PowerShell
   Starting discovery in 1 files.
   Discovery found 6 tests in 11ms.
   Running tests.
   [+] \benchpress\examples\ContainerRegistry.Tests.ps1 94.43s (94.38s|48ms)
   Tests completed in 5.79s
   Tests Passed: 6, Failed: 0, Skipped: 0 NotRun: 0
   ```
