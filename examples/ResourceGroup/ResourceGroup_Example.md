# How To Run ResourceGroup.Tests.ps1

`ResourceGroup.Tests.ps1` contains examples of using the `Confirm-AzBPResourceGroup` cmdlet.

## Pre-Requisites

- An Azure subscription to deploy resources to
- A [service principal][1] with a client secret created that has contributor access on the Azure subscription

[1]: <https://learn.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal>

## Steps

1. Follow the [installation guide](../../docs/installation.md) to install `Az-InfrastructureTest` from the PowerShell
Gallery or from a local copy.
1. Follow the Setting Up section in the [getting started guide](../../docs/getting_started.md) to configure the
required environment variables.
1. Navigate to ResourceGroup directory:

   ```Powershell
   cd examples\ResourceGroup\
   ```

1. Deploy the Resource Group to your subscription:

   ```Powershell
    New-AzSubscriptionDeployment -TemplateFile ".\resourceGroup.bicep" `
    -Location "WestUS3"
   ```

1. Update `ResourceGroup.Tests.ps1` variables to point to your expected resources:

   - `rgtest` -> `your-resource-group-name`

1. If using a local copy of `Az-InfrastructureTest`, replace `Import-Module Az-InfrastructureTest` with
`Import-Module "../../bin/BenchPress.Azure.psd1"`.

1. Run `ResourceGroup.Tests.ps1`:

   ```Powershell
   Invoke-Pester -Path .\ResourceGroup.Tests.ps1
   ```

1. Success!

   ```Powershell
   Tests completed in 952ms
   Tests Passed: 2, Failed: 0, Skipped: 0 NotRun: 0
   ```

1. Don't forget to delete any deployed resources that are no longer needed.
