# How To Run AksCluster.Tests.ps1

`AksCluster.Tests.ps1` contains examples of using the `Confirm-AzBPAksCluster` cmdlet.

## Pre-Requisites

- Follow the [setup instructions](../README.md)

## Steps

1. Navigate to AksCluster directory:

   ```Powershell
   cd examples\AksCluster\
   ```

1. Deploy the AKS Cluster to your resource group:

   ```Powershell
    New-AzResourceGroupDeployment -ResourceGroupName "<your-resource-group-name>"`
    -TemplateFile ".\aksCluster.bicep"
   ```

1. Update `AksCluster.Tests.ps1` variables to point to your expected resources:

   - `rg-test`                -> `your-resource-group-name`
   - `aksbenchpresstest`      -> `your-aks-name`
   - `nodepoolbenchpresstest` -> `your-aks-node-pool-name`
   - `westus3`                -> `your-resource-group-location-name`

1. If using a local copy of `BenchPress.Azure`, replace `Import-Module BenchPress.Azure` with
`Import-Module "../../bin/BenchPress.Azure.psd1"`. Note that the final `AfterAll` step will properly remove the module
regardless of which method is chosen to load the module.

1. Run `AksCluster.Tests.ps1`:

   ```Powershell
   Invoke-Pester -Path .\AksCluster.Tests.ps1
   ```

1. Success!

   ```Powershell
   Tests completed in 952ms
   Tests Passed: 2, Failed: 0, Skipped: 0 NotRun: 0
   ```

1. Don't forget to delete any deployed resources that are no longer needed.
