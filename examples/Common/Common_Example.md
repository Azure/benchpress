# How To Run Common.Tests.ps1

`Common.Tests.ps1` contains examples of using the `Get-AzBPResourceByType`, `Get-AzBPResource`, and
`Confirm-AzBPResource` cmdlets.

## Pre-Requisites

- Follow the [setup instructions](../README.md)

## Steps

1. Navigate to Common directory:

   ```Powershell
   cd examples\Common\
   ```

1. Deploy the resources (VM, Container Registry, SQL, and Key Vault) to your resource group:

   ```Powershell
    New-AzResourceGroupDeployment -ResourceGroupName "<your-resource-group-name>"`
    -TemplateFile ".\common.bicep"
   ```

1. When prompted in your terminal, set the `svcPrincipalObjectId` parameter with your service principal's object ID.

1. When prompted in your terminal, set the `vmAdminPasswordOrKey` and `sqlAdminPassword` parameters with your own
passwords.

1. Update `Common.Tests.ps1` variables to point to your expected resources:

   - `rg-test` -> `your-resource-group-name`
   - `testvm` -> `your-virtual-machine-name`
   - `testcontaineregistry` -> `your-container-registry-name`
   - `testserver` -> `your-sql-server-name`
   - `testdb` -> `your-sql-db-name`
   - `testkv` -> `your-key-vault-name`
   - `testsp` -> `your-service-principal-name`
   - `<your-testsp-appid>` - `your-service-principal-app-id`

1. If using a local copy of `Az.InfrastructureTesting`, replace `Import-Module Az.InfrastructureTesting` with
`Import-Module "../../bin/BenchPress.Azure.psd1"`.

1. Run `Common.Tests.ps1`:

   ```Powershell
   Invoke-Pester -Path .\Common.Tests.ps1
   ```

1. Success!

   ```Powershell
   Tests completed in 7.78s
   Tests Passed: 13, Failed: 0, Skipped: 0 NotRun: 0
   ```

1. Don't forget to delete any deployed resources that are no longer needed.
