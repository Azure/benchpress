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

   - `rg-name`         -> `your-resource-group-name`
   - `account-name`    -> `your-cosmosdb-account-name`
   - `gremlin-db-name` -> `your-gremlin-db-name`
   - `mongodb-db-name` -> `your-mongodb-db-name`
   - `sql-db-name`     -> `your-sql-db-name`

1. If using a local copy of `Az-InfrastructureTest`, replace `Import-Module Az-InfrastructureTest` with
`Import-Module "../../bin/BenchPress.Azure.psd1"`.

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
