# How To Run Dashboard.Tests.ps1

`Dashboard.Tests.ps1` contains examples of using the `Confirm-AzBPPortalDashboard` cmdlet.

## Pre-Requisites

- Follow the [setup instructions](../README.md)

## Steps

1. Navigate to Dashboard directory:

   ```Powershell
   cd examples\Dashboard\
   ```

1. Deploy the Azure Dashboard to your resource group:

   ```Powershell
    New-AzResourceGroupDeployment -ResourceGroupName "<your-resource-group-name>"`
    -TemplateFile ".\dashboard.bicep"
   ```

1. Update `Dashboard.Tests.ps1` variables to point to your expected resources:

   - `rg-test`         -> `your-resource-group-name`
   - `sampleDashboard` -> `your-dashboard-name`
   - `westus3`         -> `your-dashboard-location`

1. If using a local copy of `Az.InfrastructureTesting`, replace `Import-Module Az.InfrastructureTesting` with
`Import-Module "../../bin/BenchPress.Azure.psd1"`. Note that the final `AfterAll` step will properly remove the module
regardless of which method is chosen to load the module.

1. Run `Dashboard.Tests.ps1`:

   ```Powershell
   Invoke-Pester -Path .\Dashboard.Tests.ps1
   ```

1. Success!

   ```Powershell
    Tests completed in 2.25s
    Tests Passed: 6, Failed: 0, Skipped: 0 NotRun: 0
   ```

1. Don't forget to delete any deployed resources that are no longer needed.
