# Getting Started with BenchPress

## BenchPress intro

The basic usage pattern for writing automated tests with BenchPress is to:

1. Write tests using [Pester testing framework](https://pester.dev/docs/quick-start). Create test files ending in
   `Tests.ps1` and run test files using `Invoke-Pester` .
1. Deploy resources to Azure using bicep (or helpers from BenchPress).
1. Use BenchPress to return information about deployed resources.
1. (Optional) Use BenchPress to tear down resources at the end of the test.

## Requirements

BenchPress uses PowerShell and the Azure Az PowerShell module. Users should use Pester
as their testing framework and runner. To use BenchPress, have the following installed:

- [PowerShell](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows)
  (PowerShell 7+ recommended)
- [Az PowerShell module](https://learn.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-9.3.0)
- [Pester](https://pester.dev/docs/introduction/installation)
- [Bicep](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/install#azure-powershell)
- [Service Principal](https://learn.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal)
  created for your application.

An Azure subscription that you can deploy resources to is also a requirement.

## Setting up your project

The easiest way to get started with BenchPress is to use the files in the `examples` folder.

1. Clone the repository, open a PowerShell terminal, and navigate to the `examples` folder.

1. Set the following environment variables so that the BenchPress tools can deploy (if necessary), confirm, and destroy
   (if necessary) resources in the target subscription.

- AZ_APPLICATION_ID - The Service Principal's application ID
- AZ_TENANT_ID - The Tenant ID of the Azure Tenant to access
- AZ_SUBSCRIPTION_ID - The Subscription ID of the Subscription within the Tenant to access
- AZ_ENCRYPTED_PASSWORD - The **encrypted** password of the Service Principal. This value must be an encrypted string.
  It is the responsibility of the user to encrypt the Service Principal password. The following PowerShell code can be
  used to encrypt the Service Principal password before saving as an environment variable:
  `<raw password> | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString`.
  This takes the raw password and converts the password to a SecureString. This SecureString must then be converted to
  a String. `ConvertFrom-SecureString` will take the SecureString and convert it to an encrypted string. This value
  must then be saved as an environment variable. This ensures that the BenchPress code never uses the raw password at
  any point.

  You can either use a `.env` file and pass in the environment variables locally with a script,
  or you must load each variable through the command line using:

    ```PowerShell
    $Env:AZ_APPLICATION_ID="<sample-application-id>"
    $Env:AZ_TENANT_ID="<sample-tenant-id>"
    $Env:AZ_SUBSCRIPTION_ID="<sample-subscription-id>"
    $Env:AZ_ENCRYPTED_PASSWORD="<sample-encrypted-password>"
    ```

  You can confirm if these are set up right on your local powershell using:

    ```PowerShell
    [Environment]::GetEnvironmentVariables()
    ```

## Running a test file

1. You can use any of the `*.Tests.ps1` for this quickstart, but we will specifically use `containerRegistry.bicep` and
   `ContainerRegistry.Tests.ps1` as our examples. To run the `ContainerRegistry.Tests.ps1` tests, execute
   `.\ContainerRegistry.Tests.ps1` or `Invoke-Pester -Path .\ContainerRegistry.Tests.ps1`.

1. Your test results will most likely be two test failures:

   ```PowerShell
    Starting discovery in 1 files.
    Discovery found 3 tests in 44ms.
    Running tests.
    Get-AzContainerRegistry: The Resource
    'Microsoft.ContainerRegistry/registries/acrbenchpresstest1' under
    resource group 'rg-test' was not found.
    For more details please go to https://aka.ms/ARMResourceNotFoundFix
    [-] Verify Container Registry.Should contain a container registry with the given name 894ms (893ms|1ms)
    Expected $true, but got $false.
    at $result.Success | Should -Be $true,
    BenchPress\benchpress\examples\ContainerRegistry.Tests.ps1:15
    at <ScriptBlock>, BenchPress\benchpress\examples\ContainerRegistry.Tests.ps1:15
    New-AzResourceGroupDeployment: 3:01:24 PM -
    Error: Code=ResourceGroupNotFound; Message=Resource group
    'rg-test' could not be found.
    New-AzResourceGroupDeployment: The deployment validation failed
    [-] Spin up , Tear down Container Registry.Should deploy a bicep file. 4.52s (4.52s|1ms)
    Expected 'Succeeded', but got $null.
    at $deployment.ProvisioningState | Should -Be "Succeeded", BenchPress\benchpress\examples\ContainerRegistry.Tests.ps1:50
    at <ScriptBlock>, BenchPress\benchpress\examples\ContainerRegistry.Tests.ps1:50
    Tests completed in 6.3s
    Tests Passed: 1, Failed: 2, Skipped: 0 NotRun: 0
   ```

## Walkthrough of Test File

Let's walkthrough the `ContainerRegistry.Tests.ps1` file to understand how BenchPress is used to test our
Infrastructure as Code (IaC) and why our tests are failing.

```PowerShell
BeforeAll {
  Import-Module "../BenchPress/Helpers/Azure/BenchPress.Azure.psd1"
}

Describe 'Verify Container Registry' {
  it 'Should contain a container registry with the given name' {
    #arrange
    $rgName = "rg-test"
    $acrName = "acrbenchpresstest1"

    #act
    $result = Confirm-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName

    #assert
    $result.Success | Should -Be $true
  }
}

Describe 'Verify Container Registry Does Not Exist' {
  it 'Should not contain a container registry with the given name' {
    #arrange
    $rgName = "rg-test"
    $acrName = "acrbenchpresstest1"

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }
}

Describe 'Spin up , Tear down Container Registry' {
  it 'Should deploy a bicep file.' {
    #arrange
    $resourceGroupName = "rg-test"
    $bicepPath = "./containerRegistry.bicep"
    $params = @{
      name           = "acrbenchpresstest2"
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
```

This test file uses Pester's `Describe` and `It` keywords to represent three tests. Each test checks very similar
scenarios (whether a Container Registry exists) but uses BenchPress in slightly different ways. We also import the
BenchPress module in the `BeforeAll` block.

Let's look at the first `Describe` block:

```PowerShell
Describe 'Verify Container Registry' {
  it 'Should contain a container registry with the given name' {
    #arrange
    $rgName = "rg-test"
    $acrName = "acrbenchpresstest1"

    #act
    $result = Confirm-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName

    #assert
    $result.Success | Should -Be $true
  }
}
```

This test uses the `Confirm-AzBPContainerRegistry` helper
from BenchPress. `Confirm-AzBPContainerRegistry` returns a `ConfirmResult` object
with information about the success of the call,
resource details, authentication data and an error record.
Assuming the container registry exists, we assert that
the object returned by `Confirm-AzBPContainerRegistry` is successful.

Let's look at the second `Describe` block:

```PowerShell
Describe 'Verify Container Registry Does Not Exist' {
  it 'Should not contain a container registry with the given name' {
    #arrange
    $rgName = "rg-test"
    $acrName = "acrbenchpresstest1"

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }
}
```

This test looks very similar to the first test, except it checks that the container registry does not exist.
Take note of the `-ErrorAction SilentlyContinue` comment.

Now let's look at the third `Describe` block:

```PowerShell
Describe 'Spin up , Tear down Container Registry' {
  it 'Should deploy a bicep file.' {
    #arrange
    $resourceGroupName = "rg-test"
    $bicepPath = "./containerRegistry.bicep"
    $params = @{
      name           = "acrbenchpresstest2"
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
```

This test is unlike the first two tests because we are using the `Deploy-AzBPBicepFeature` helper to deploy a bicep
file. `Deploy-AzBicepFeature` will take a bicep file and deploy it to an existing resource group, and it will return
the deployment details. As you can see, we instead assert that the deployment should be successful. We then tear down
the deployed resources using the `Remove-AzBPBicepFeature` helper.

## Fixing the Tests

Now that we've done a walkthrough of the three tests, let's fix them.

The first test assumed that our container registry was already deployed to a resource group. However, we
never deployed the `containerRegistry.bicep` file ourselves! The third test assumed we had an existing resource group
to deploy to, but we never deployed that either! Let's go ahead and fix these assumptions now:

1. Create a resource group in your subscription.
1. Deploy the container registry bicep file to that resource group:

   ```PowerShell
   New-AzResourceGroupDeployment -ResourceGroupName "<your-resource-group-name>"`
    -TemplateFile ".\containerRegistry.bicep"
   ```

   (If you get an error that bicep is not recognized, you may need to
   [manually install](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/install#azure-powershell)
   bicep.)

1. Update the `ContainerRegistry.Tests.ps1` file to point to your new resource group:
   `$rgName = "<your-resource-group-name>"`
1. Run your test again! Success!

   ```PowerShell
   Starting discovery in 1 files.
   Discovery found 3 tests in 11ms.
   Running tests.
   [+] \benchpress\examples\ContainerRegistry.Tests.ps1 94.43s (94.38s|48ms)
   Tests completed in 94.44s
   Tests Passed: 3, Failed: 0, Skipped: 0 NotRun: 0
   ```
