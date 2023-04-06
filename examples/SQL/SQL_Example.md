# How To Run SQL.Tests.ps1

`SQL.Tests.ps1` contains examples of using the `Confirm-AzBPSqlDatabase` and `Confirm-AzBPSqlServer` cmdlets.

## Pre-Requisites

- Follow the [setup instructions](../README.md)

## Steps

1. Navigate to SQL directory:

   ```Powershell
   cd examples\SQL\
   ```

1. Deploy the SQL Database and Server to your resource group:

   ```Powershell
    New-AzResourceGroupDeployment -ResourceGroupName "<your-resource-group-name>"`
    -TemplateFile ".\sql.bicep"
   ```

1. When prompted in your terminal, set the `adminPassword` parameter with your own password.

1. Update `SQL.Tests.ps1` variables to point to your expected resources:

   - `rg-test`           -> `your-resource-group-name`
   - `samplesqlserver`   -> `your-sql-server-name`
   - `samplesqldatabase` -> `your-sql-db-name`
   - `westus3`           -> `your-sql-database-location`

1. If using a local copy of `Az.InfrastructureTesting`, replace `Import-Module Az.InfrastructureTesting` with
`Import-Module "../../bin/BenchPress.Azure.psd1"`. Note that the final `AfterAll` step will properly remove the module
regardless of which method is chosen to load the module.

1. Run `SQL.Tests.ps1`:

   ```Powershell
   Invoke-Pester -Path .\SQL.Tests.ps1
   ```

1. Success!

   ```Powershell
   Tests completed in 952ms
   Tests Passed: 2, Failed: 0, Skipped: 0 NotRun: 0
   ```

1. Don't forget to delete any deployed resources that are no longer needed.
