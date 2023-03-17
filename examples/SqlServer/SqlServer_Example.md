# How To Run SqlServer.Tests.ps1

`SqlServer.Tests.ps1` contains examples of using the `Confirm-AzBPSqlServer` cmdlet.

## Pre-Requisites

- Follow the [setup instructions](../README.md)

## Steps

1. Navigate to SqlServer directory:

   ```Powershell
   cd examples\SqlServer\
   ```

1. Deploy the SQL Database to your resource group:

   ```Powershell
    New-AzResourceGroupDeployment -ResourceGroupName "<your-resource-group-name>"`
    -TemplateFile ".\sqlServer.bicep"
   ```

1. When prompted in your terminal, set the `adminPassword` parameter with your own password.

1. Update `SqlServer.Tests.ps1` variables to point to your expected resources:

   - `rg-test` -> `your-resource-group-name`
   - `samplesqlserver` -> `your-sql-server-name`

1. If using a local copy of `Az.InfrastructureTesting`, replace `Import-Module Az.InfrastructureTesting` with
`Import-Module "../../bin/BenchPress.Azure.psd1"`.

1. Run `SqlServer.Tests.ps1`:

   ```Powershell
   Invoke-Pester -Path .\SqlServer.Tests.ps1
   ```

1. Success!

   ```Powershell
   Tests completed in 952ms
   Tests Passed: 2, Failed: 0, Skipped: 0 NotRun: 0
   ```

1. Don't forget to delete any deployed resources that are no longer needed.
