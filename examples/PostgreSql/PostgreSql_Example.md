# How To Run PostgreSql.Tests.ps1

`PostgreSql.Tests.ps1` contains examples of using the `Confirm-AzBPPostgreSqlFlexibleServer` cmdlet.

## Pre-Requisites

- Follow the [setup instructions](../README.md)

## Steps

1. Navigate to PostgreSql directory:

   ```Powershell
   cd examples/PostgreSql/
   ```

1. Deploy the PostgreSQL Flexible Server to your subscription:

   ```Powershell
    New-AzResourceGroupDeployment -TemplateFile "./PostgreSql.bicep" -ResourceGroupName "rg-test"
   ```

1. Update `PostgreSql.Tests.ps1` variables to point to your expected resources:

   - `rg-test`                -> `your-resource-group-name`
   - `samplepostgresqlserver` -> `your-postgresql-server-name`
   - `westus3`                -> `your-sql-server-location`

1. If using a local copy of `Az.InfrastructureTesting`, replace `Import-Module Az.InfrastructureTesting` with
`Import-Module "../../bin/BenchPress.Azure.psd1"`. Note that the final `AfterAll` step will properly remove the module
regardless of which method is chosen to load the module.

1. Run `PostgreSql.Tests.ps1`:

   ```Powershell
   Invoke-Pester -Path ./PostgreSql.Tests.ps1
   ```

1. Success!

   ```Powershell
   Tests completed in 952ms
   Tests Passed: 2, Failed: 0, Skipped: 0 NotRun: 0
   ```

1. Don't forget to delete any deployed resources that are no longer needed.
