# How To Run AppServicePlan.Tests.ps1

`AppServicePlan.Tests.ps1` contains examples of using the `Confirm-AzBPAppServicePlan` cmdlet.

## Pre-Requisites

- Follow the [setup instructions](../README.md)

## Steps

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

1. Don't forget to delete any deployed resources that are no longer needed.
