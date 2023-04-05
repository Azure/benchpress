# How To Run CosmosDB*.Tests.ps1

The `CosmosDB*.Tests.ps1` files contain examples of using the `Confirm-AzBPCosmosDB*` cmdlets.

## Pre-Requisites

- Follow the [setup instructions](../README.md)

## Steps

1. Navigate to CosmosDB directory:

   ```Powershell
   cd examples\CosmosDB\
   ```

1. Deploy the Cosmos DB to your resource group:

   ```Powershell
    New-AzResourceGroupDeployment -ResourceGroupName "<your-resource-group-name>"`
    -TemplateFile ".\cosmosDB.bicep"
   ```

1. Update `CosmosDB.Tests.ps1` variables to point to your expected resources:

   - `rg-test`                 -> `your-resource-group-name`
   - `gremlin-account-name`    -> `your-gremlin-account-name`
   - `gremlin-db-name`         -> `your-gremlin-db-name`
   - `mongodb-account-name`    -> `your-mongodb-account-name`
   - `mongodb-db-name`         -> `your-mongodb-db-name`
   - `sql-account-name`        -> `your-sql-account-name`
   - `sql-db-name`             -> `your-sql-db-name`
   - `westus3`                 -> `your-resource-group-location-name`
   - `sqlroleassignmentbptest` -> `your-role-assignment-id-name`
   - `sqlroledefinitionbptest` -> `your-role-definition-id-name`

1. If using a local copy of `Az.InfrastructureTesting`, replace `Import-Module Az.InfrastructureTesting` with
`Import-Module "../../bin/BenchPress.Azure.psd1"`. Note that the final `AfterAll` step will properly remove the module
regardless of which method is chosen to load the module.

1. Run `CosmosDB.Tests.ps1`:

   ```Powershell
   Invoke-Pester -Path .\CosmosDB.Tests.ps1
   ```

1. Success!

   ```Powershell
   Tests completed in 952ms
   Tests Passed: 8, Failed: 0, Skipped: 0 NotRun: 0
   ```

1. Don't forget to delete any deployed resources that are no longer needed.
