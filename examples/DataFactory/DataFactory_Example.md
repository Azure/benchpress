# How To Run DataFactory.Tests.ps1

`DataFactory.Tests.ps1` contains examples of using the `Confirm-AzBPDataFactory`
and `Confirm-AzBPDataFactoryLinkedService` cmdlet.

## Pre-Requisites

- Follow the [setup instructions](../README.md)

## Steps

1. Navigate to DataFactory directory:

   ```Powershell
   cd examples\DataFactory\
   ```

1. Deploy the Data Factory to your resource group:

   ```Powershell
    New-AzResourceGroupDeployment -ResourceGroupName "<your-resource-group-name>"`
    -TemplateFile ".\dataFactory.bicep"
   ```

1. Update `DataFactory.Tests.ps1` variables to point to your expected resources:

   - `rg-test` -> `your-resource-group-name`
   - `westus3` -> `your-data-factory-location`
   - `sampleadf` -> `your-data-factory-name`

1. If using a local copy of `Az.InfrastructureTesting`, replace `Import-Module Az.InfrastructureTesting` with
`Import-Module "../../bin/BenchPress.Azure.psd1"`.

1. Run `DataFactory.Tests.ps1`:

   ```Powershell
   Invoke-Pester -Path .\DataFactory.Tests.ps1
   ```

1. Success!

   ```Powershell
   Tests completed in 4.43s
   Tests Passed: 4, Failed: 0, Skipped: 0 NotRun: 0
   ```

1. Don't forget to delete any deployed resources that are no longer needed.
