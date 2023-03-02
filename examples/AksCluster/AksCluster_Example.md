# How To Run AksCluster.Tests.ps1

`AksCluster.Tests.ps1` contains examples of using the `Confirm-AzBPAksCluster` cmdlet.

## Pre-Requisites

- An Azure subscription to deploy resources to
- A resource group deployed to the Azure subscription
- A [service principal](https://learn.microsoft.com/en-us/cli/azurecreate-an-azure-service-principal-azure-cli)
with a client secret created that has contributor access on the Azure subscription

## Steps

1. Follow the [installation guide](../../docs/installation.md) to install `Az-InfrastructureTest` from the PowerShell
Gallery or from a local copy.
1. Follow the Setting Up section in the [getting started guide](../../docs/getting_started.md) to configure the
required environment variables.
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

   - `rg-test` -> `your-resource-group-name`
   - `aksbenchpresstest` -> `your-aks-name`

1. If using a local copy of `Az-InfrastructureTest`, replace `Import-Module Az-InfrastructureTest` with
`Import-Module "../../bin/BenchPress.Azure.psd1"`.

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
