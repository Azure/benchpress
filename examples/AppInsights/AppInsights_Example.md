# How To Run AppInsights.Tests.ps1

`AppInsights.Tests.ps1` contains examples of using the `Confirm-AzBPAppInsights`
and `Confirm-AzBPDiagnosticSetting` cmdlets.

## Pre-Requisites

- Follow the [setup instructions](../README.md)

## Steps

1. Navigate to AppInsights directory:

   ```Powershell
   cd examples\AppInsights\
   ```

1. Deploy the Application Insights to your resource group:

   ```Powershell
    New-AzResourceGroupDeployment -ResourceGroupName "<your-resource-group-name>"`
    -TemplateFile ".\appInsights.bicep"
   ```

1. Update `AppInsights.Tests.ps1` variables to point to your expected resources:

   - `rg-test`               -> `your-resource-group-name`
   - `appinsightstest`       -> `your-app-insights-name`
   - `westus3`               -> `your-resource-group-location-name`
   - `diagnosticsettingtest` -> `your-diagnostic-setting-name`
   - `path/for/resourceId`   -> `your-resource-id`

1. If using a local copy of `Az.InfrastructureTesting`, replace `Import-Module Az.InfrastructureTesting` with
`Import-Module "../../bin/BenchPress.Azure.psd1"`. Note that the final `AfterAll` step will properly remove the module
regardless of which method is chosen to load the module.

1. Run `AppInsights.Tests.ps1`:

   ```Powershell
   Invoke-Pester -Path .\AppInsights.Tests.ps1
   ```

1. Success!

   ```Powershell
   Tests completed in 952ms
   Tests Passed: 2, Failed: 0, Skipped: 0 NotRun: 0
   ```

1. Don't forget to delete any deployed resources that are no longer needed.
