# How To Run AppServicePlan.Tests.ps1

`AppServicePlan.Tests.ps1` contains examples of using the `Confirm-AzBPAppServicePlan` cmdlet.

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
1. Navigate to AppServicePlan directory:

   ```Powershell
   cd examples\AppServicePlan\
   ```

1. Deploy the App Service Plan to your resource group:

   ```Powershell
    New-AzResourceGroupDeployment -ResourceGroupName "<your-resource-group-name>"`
    -TemplateFile ".\appServicePlan.bicep"
   ```

1. Update `AppServicePlan.Tests.ps1` variables to point to your expected resources:

   - `rg-test` -> `your-resource-group-name`
   - `appserviceplantest` -> `your-app-service-plan-name`

1. If using a local copy of `Az-InfrastructureTest`, replace `Import-Module Az-InfrastructureTest` with
`Import-Module "../../bin/BenchPress.Azure.psd1"`.

1. Run `AppServicePlan.Tests.ps1`:

   ```Powershell
   Invoke-Pester -Path .\AppServicePlan.Tests.ps1
   ```

1. Success!

   ```Powershell
   Tests completed in 952ms
   Tests Passed: 2, Failed: 0, Skipped: 0 NotRun: 0
   ```
