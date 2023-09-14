# How To Run SearchService.Tests.ps1

`SearchService.Tests.ps1` contains examples of using the `Confirm-AzBPSearchService` cmdlet.

## Pre-Requisites

- Follow the [setup instructions](../README.md)

## Steps

1. Navigate to SearchService directory:

   ```Powershell
   cd examples\SearchService\
   ```

1. Deploy the Search Service to your resource group:

   ```Powershell
    New-AzResourceGroupDeployment -ResourceGroupName "<your-resource-group-name>" -TemplateFile ".\SearchService.bicep"
   ```

1. Update `SearchService.Tests.ps1` variables to point to your expected resources:

   - `rg-test`             -> `your-resource-group-name`
   - `samplesearchservice` -> `your-search-service-name`
   - `westus3`             -> `your-search-service-location`

1. If using a local copy of `Az.InfrastructureTesting`, replace `Import-Module Az.InfrastructureTesting` with `Import-Module "../../bin/BenchPress.Azure.psd1"`. Note that the final `AfterAll` step will properly remove the module regardless of which method is chosen to load the module.

1. Run `SearchService.Tests.ps1`:

   ```Powershell
   Invoke-Pester -Path .\SearchService.Tests.ps1
   ```

1. Success!

   ```Powershell
   Tests completed in 2.14s
   Tests Passed: 5, Failed: 0, Skipped: 0 NotRun: 0
   ```

1. Don't forget to delete any deployed resources that are no longer needed.
