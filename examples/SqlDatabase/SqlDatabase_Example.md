# How To Run SqlDatabase.Tests.ps1

`SqlDatabase.Tests.ps1` contains examples of using the `Confirm-AzBPSqlDatabase` cmdlet.

## Pre-Requisites

- Follow the [setup instructions](../README.md)

## Steps

1. Navigate to SqlDatabase directory:

   ```Powershell
   cd examples\SqlDatabase\
   ```

1. Deploy the SQL Database to your resource group:

   ```Powershell
    New-AzResourceGroupDeployment -ResourceGroupName "<your-resource-group-name>"`
    -TemplateFile ".\sqlDatabase.bicep"
   ```

1. When prompted in your terminal, set the `adminPassword` parameter with your own password.

1. Update `SqlDatabase.Tests.ps1` variables to point to your expected resources:

   - `rg-test` -> `your-resource-group-name`
   - `samplesqlserver` -> `your-sql-server-name`
   - `samplesqldatabase` -> `your-sql-db-name`
   - `westus3` -> `your-sql-database-location`

1. If using a local copy of `Az.InfrastructureTesting`, replace `Import-Module Az.InfrastructureTesting` with
`Import-Module "../../bin/BenchPress.Azure.psd1"`. Note that the final `AfterAll` step will properly remove the moduleregardless of which method is chosen to load the module.

1. Run `SqlDatabase.Tests.ps1`:

   ```Powershell
   Invoke-Pester -Path .\SqlDatabase.Tests.ps1
   ```

1. Success!

   ```Powershell
   Tests completed in 952ms
   Tests Passed: 2, Failed: 0, Skipped: 0 NotRun: 0
   ```

1. Don't forget to delete any deployed resources that are no longer needed.
