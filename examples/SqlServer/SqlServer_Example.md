# How To Run SqlServer.Tests.ps1

`SqlServer.Tests.ps1` contains examples of using the `Confirm-AzBPSqlServer` cmdlet.

## Pre-Requisites

- An Azure subscription to deploy resources to
- A resource group deployed to the Azure subscription
- A [service principal](https://learn.microsoft.com/en-us/cli/azurecreate-an-azure-service-principal-azure-cli#password-based-authentication)
that has contributor access on the Azure subscription

## Steps

1. Follow the [installation guide](../../docs/installation.md) to install `Az-InfrastructureTest` from the PowerShell
Gallery or from a local copy.
1. Follow the Setting Up section in the [getting started guide](../../docs/getting_started.md) to configure the
required environment variables.
1. Navigate to SqlServer directory:

   ```Powershell
   cd examples\SqlServer\
   ```

1. Deploy the SQL Database to your resource group:

   ```Powershell
    New-AzResourceGroupDeployment -ResourceGroupName "<your-resource-group-name>"`
    -TemplateFile ".\sqlServer.bicep"
   ```

1. When prompted in your terminal, set the `adminPassword` parameter with your own password.

1. Update `SqlServer.Tests.ps1` variables to point to your expected resources:

   - `rg-test` -> `your-resource-group-name`
   - `samplesqlserver` -> `your-sql-server-name`

1. If using a local copy of `Az-InfrastructureTest`, replace `Import-Module Az-InfrastructureTest` with
`Import-Module "../../bin/BenchPress.Azure.psd1"`.

1. Run `SqlServer.Tests.ps1`:

   ```Powershell
   Invoke-Pester -Path .\SqlServer.Tests.ps1
   ```

1. Success!

   ```Powershell
   Tests completed in 952ms
   Tests Passed: 2, Failed: 0, Skipped: 0 NotRun: 0
   ```

1. Don't forget to delete any deployed resources that are no longer needed.
