# How To Run WebApp.Tests.ps1

`WebApp.Tests.ps1` contains examples of using the `Confirm-AzBPWebApp` cmdlet.

## Pre-Requisites

- Follow the [setup instructions](../README.md)

## Steps

1. Navigate to WebApp directory:

   ```Powershell
   cd examples\WebApp\
   ```

1. Deploy the Web App to your resource group:

   ```Powershell
    New-AzResourceGroupDeployment -ResourceGroupName "<your-resource-group-name>"`
    -TemplateFile ".\webApp.bicep"
   ```

1. Update `WebApp.Tests.ps1` variables to point to your expected resources:

   - `rg-test`        -> `your-resource-group-name`
   - `westus3`        -> `your-resource-group-location`
   - `azbpwebapptest` -> `your-web-app-name`

1. If using a local copy of `Az.InfrastructureTesting`, replace `Import-Module Az.InfrastructureTesting` with
`Import-Module "../../bin/BenchPress.Azure.psd1"`.

1. Run `WebApp.Tests.ps1`:

   ```Powershell
   Invoke-Pester -Path .\WebApp.Tests.ps1
   ```

1. Success!

   ```Powershell
   Tests completed in 952ms
   Tests Passed: 2, Failed: 0, Skipped: 0 NotRun: 0
   ```

1. Don't forget to delete any deployed resources that are no longer needed.
