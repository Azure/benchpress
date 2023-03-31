# How To Run ContainerApp.Tests.ps1

`ContainerApp.Tests.ps1` contains examples of using the `Confirm-AzBPContainerApp` and the
`Confirm-AzBPContainerAppManagedEnv` cmdlet.

## Pre-Requisites

- Follow the [setup instructions](../README.md)

## Steps

1. Navigate to ContainerApp directory:

   ```Powershell
   cd examples\ContainerApp\
   ```

1. Deploy the Container Registry to your resource group:

   ```Powershell
    New-AzResourceGroupDeployment -ResourceGroupName "<your-resource-group-name>"`
    -TemplateFile ".\containerApp.bicep"
   ```

1. Update `ContainerApp.Tests.ps1` variables to point to your expected resources:

   - `rg-test`                  -> `your-resource-group-name`
   - `conAppBenchPressTest`     -> `your-container-application-name`
   - `managedenvbenchpresstest` -> `your-container-application-managed-environment-name`
   - `westus3`                  -> `your-resource-group-location-name`

1. If using a local copy of `Az.InfrastructureTesting`, replace `Import-Module Az.InfrastructureTesting` with
`Import-Module "../../bin/BenchPress.Azure.psd1"`. Note that the final `AfterAll` step will properly remove the module
regardless of which method is chosen to load the module.

1. Run `ContainerApp.Tests.ps1`:

   ```Powershell
   Invoke-Pester -Path .\ContainerApp.Tests.ps1
   ```

1. Success!

   ```Powershell
    Tests completed in 5.02s
    Tests Passed: 7, Failed: 0, Skipped: 0 NotRun: 0
   ```

1. Don't forget to delete any deployed resources that are no longer needed.
