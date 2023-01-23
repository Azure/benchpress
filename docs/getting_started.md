# Getting Started with BenchPress

## BenchPress intro

The basic usage pattern for writing automated tests with BenchPress is to:

1. Write tests using [Pester testing framework](https://pester.dev/docs/quick-start). Create test files ending in `Tests.ps1` and run test files using `Invoke-Pester` .
1. Deploy resources to Azure using bicep (or helpers from BenchPress)
1. Use BenchPress to return information about deployed resources.
1. Use BenchPress to tear down resources at the end of the test (unless there is another service that handles teardown i.e. a step in a CI/CD process that tears down infrastructure).

## Requirements

BenchPress uses PowerShell and the Azure Az PowerShell module. It is also expected of users of BenchPress to use Pester as their testing framework and runner. To use BenchPress, have the following installed:

- [PowerShell](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.3) (PowerShell 7+ recommended)
- [Az PowerShell module](https://learn.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-9.3.0)
- [Pester](https://pester.dev/docs/introduction/installation)

An Azure subscription that you can deploy resources to is also a requirement.

## Setting up your project

The easiest way to get started with BenchPress is to use the files in the `examples` folder.

1. Clone the repository, open a PowerShell terminal, and navigate to the `examples` folder.

1. Login to your Azure subscription by running `Connect-AzAccount` and follow the additional prompts to login.

## Running a test file

1. You can use any of the `*.Tests.ps1` for this quickstart, but we will specifically use `containerRegistry.bicep` and `ContainerRegistry.Tests.ps1` as our examples. To run the `ContainerRegistry.Tests.ps1` tests, execute `.\ContainerRegistry.Tests.ps1` or `Invoke-Pester -Path .\ContainerRegistry.Tests.ps1`.

1. Your test results will most likely be three test failures:

  ```PowerShell
  Starting discovery in 1 files.
  Discovery found 3 tests in 40ms.
  Running tests.
  Get-AzContainerRegistry: Resource group 'rg-test' could not be found.
  [-] Verify Container Registry Exists.Should contain a container registry with the given name 537ms (530ms|7ms)
    Expected a value, but got $null or empty.
    at $exists | Should -Not -BeNullOrEmpty, \benchpress\examples\ContainerRegistry.Tests.ps1:15
    at <ScriptBlock>, \benchpress\examples\ContainerRegistry.Tests.ps1:15
  Get-AzContainerRegistry: Resource group 'rg-test' could not be found.
  [-] Verify Container Registry Exists.Should contain a container registry with the given name 213ms (213ms|0ms)
    Expected $true, but got $false.
    at $exists | Should -Be $true, \benchpress\examples\ContainerRegistry.Tests.ps1:29
    at <ScriptBlock>, \benchpress\examples\ContainerRegistry.Tests.ps1:29
  New-AzResourceGroupDeployment: 1:48:19 PM - Error: Code=ResourceGroupNotFound; Message=Resource group 'rg-test' could not be found.
  New-AzResourceGroupDeployment: The deployment validation failed
  [-] Spin up , Tear down Container Registry.Should deploy a bicep file. 6.01s (6.01s|0ms)
    Expected 'Succeeded', but got $null.
    at $deployment.ProvisioningState | Should -Be "Succeeded", \benchpress\examples\ContainerRegistry.Tests.ps1:47
    at <ScriptBlock>, \benchpress\examples\ContainerRegistry.Tests.ps1:47
  Tests completed in 4.74s
  Tests Passed: 0, Failed: 3, Skipped: 0 NotRun: 0
  ```

## Walkthrough of Test File

Let's walkthrough the `ContainerRegistry.Tests.ps1` file to understand how BenchPress is used to test our Infrastructure as Code (IaC) and why our tests are failing.

```PowerShell
BeforeAll {
  Import-Module "../BenchPress/Helpers/Azure/BenchPress.Azure.psd1"
}

Describe 'Verify Container Registry Exists' {
  it 'Should contain a container registry with the given name' {
    #arrange
    $rgName = "rg-test"
    $acrName = "acrbenchpresstest1"

    #act
    $exists = Get-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName

    #assert
    $exists | Should -Not -BeNullOrEmpty
  }
}

Describe 'Verify Container Registry Exists' {
  it 'Should contain a container registry with the given name' {
    #arrange
    $rgName = "rg-test"
    $acrName = "acrbenchpresstest1"

    #act
    $exists = Get-AzBPContainerRegistryExist -ResourceGroupName $rgName -Name $acrName

    #assert
    $exists | Should -Be $true
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

This test file uses Pester's `Describe` and `It` keywords to represent three tests. Each test checks very similar scenarios (whether a Container Registry exists) but uses BenchPress in slightly different ways.

Let's look at the first `Describe` block:

```PowerShell
Describe 'Verify Container Registry Exists' {
  it 'Should contain a container registry with the given name' {
    #arrange
    $rgName = "rg-test"
    $acrName = "acrbenchpresstest1"

    #act
    $exists = Get-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName

    #assert
    $exists | Should -Not -BeNullOrEmpty
  }
}
```

This test uses the `Get-AzBPContainerRegistry` helper from BenchPress. `Get-AzBPContainerRegistry` returns an object representing the container registry in the specified resource group and with the specified container registry name. Assuming the container registry exists, we assert that the object returned by `Get-AzBPContainerRegistry` is not null or empty.

Let's look at the second `Describe` block:

```PowerShell
Describe 'Verify Container Registry Exists' {
  it 'Should contain a container registry with the given name' {
    #arrange
    $rgName = "rg-test"
    $acrName = "acrbenchpresstest1"

    #act
    $exists = Get-AzBPContainerRegistryExist -ResourceGroupName $rgName -Name $acrName

    #assert
    $exists | Should -Be $true
  }
}
```

This test looks very similar to the first test, except it is using the `Get-AzBPContainerRegistryExist` helper instead. This helper doesn't return the object representing the Container Registry, but instead returns true if the Container Registry exists and false if it does not exists. Assuming the container registry exists, we assert that the return should be true.

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

This test is unlike the first two tests because we are using the `Deploy-AzBPBicepFeature` helper to deploy a bicep file. `Deploy-AzBicepFeature` will take a bicep file and deploy it to an existing resource group, and it will return the deployment details. As you can see, we instead assert that the deployment should be successful. We then tear down the deployed resources using the `Remove-AzBPBicepFeature` helper.

## Fixing the Tests

Now that we've done a walkthrough of the three tests, let's fix them.

The first two tests assumed that our container container registry was already deployed to a resource group. However, we never deployed the `containerRegistry.bicep` file ourselves! The third test assumed we had an existing resource group to deploy to, but we never deployed that either! Let's go ahead and fix these assumptions now:

1. Create a resource group in your subscription.
1. Deploy the container registry bicep file to that resource group: `az deployment group create --resource-group <your-resource-group-name> --template-file .\containerRegistry.bicep` (You could also use the `Deploy-AzBicepFeature` helper here)
1. Update the `ContainerRegistry.Tests.ps1` file to point to your new resource group: `$rgName = "<your-resource-group-name>"`
1. Run your test again! Success!

   ```PowerShell
   Starting discovery in 1 files.
   Discovery found 3 tests in 11ms.
   Running tests.
   [+] \benchpress\examples\ContainerRegistry.Tests.ps1 94.43s (94.38s|48ms)
   Tests completed in 94.44s
   Tests Passed: 3, Failed: 0, Skipped: 0 NotRun: 0
   ```
