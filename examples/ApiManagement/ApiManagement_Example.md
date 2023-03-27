# How To Run ApiManagement.Tests.ps1

`ApiManagement.Tests.ps1` contains examples of using the `Confirm-AzBPApiManagement`, `Confirm-AzBPApiManagementApi`,
`Confirm-AzBPApiManagementDiagnostic`, `Confirm-AzBPApiManagementLogger`, and `Confirm-AzBPApiManagementPolicy`
cmdlets.

## Pre-Requisites

- Follow the [setup instructions](../README.md)

## Steps

1. Navigate to ApiManagement directory:

   ```Powershell
   cd examples\ApiManagement\
   ```

1. Deploy the Api Management Service to your resource group:

   ```Powershell
    New-AzResourceGroupDeployment -ResourceGroupName "<your-resource-group-name>"`
    -TemplateFile ".\ApiManagement.bicep"
   ```

1. Update `ApiManagement.Tests.ps1` variables to point to your expected resources:

   - `rg-test`     -> `your-resource-group-name`
   - `servicetest` -> `your-api-management-service-name`
   - `apitest`     -> `your-api-management-api-name`
   - `diagtest`    -> `your-api-management-diagnostic-name`
   - `loggertest`  -> `your-api-managemetn-logger-name`
   - `westus`      -> `your-resource-group-location`

1. If using a local copy of `Az.InfrastructureTesting`, replace `Import-Module Az.InfrastructureTesting` with
`Import-Module "../../bin/BenchPress.Azure.psd1"`.

1. Run `ApiManagement.Tests.ps1`:

   ```Powershell
   Invoke-Pester -Path .\ApiManagement.Tests.ps1
   ```

1. Success!

   ```Powershell
   Tests completed in 20.02s
   Tests Passed: 29, Failed: 0, Skipped: 0 NotRun: 0
   ```

1. Don't forget to delete any deployed resources that are no longer needed.
