# How To Run Storage.Tests.ps1

`Storage.Tests.ps1` contains examples of using the `Confirm-AzBPStorageAccount` and the
`Confirm-AzBPStorageContainer` cmdlet.

## Pre-Requisites

- Follow the [setup instructions](../README.md)

## Steps

1. Navigate to Storage directory:

   ```Powershell
   cd examples\Storage\
   ```

1. Deploy the Storage Account to your resource group:

   ```Powershell
    New-AzResourceGroupDeployment -ResourceGroupName "<your-resource-group-name>"`
    -TemplateFile ".\storage.bicep"
   ```

1. Update `Storage.Tests.ps1` variables to point to your expected resources:

   - `rg-test` -> `your-resource-group-name`
   - `azbenchpressstorage` -> `your-storage-account-name`

1. If using a local copy of `Az.InfrastructureTesting`, replace `Import-Module Az.InfrastructureTesting` with
`Import-Module "../../bin/BenchPress.Azure.psd1"`.

1. Run `Storage.Tests.ps1`:

   ```Powershell
   Invoke-Pester -Path .\Storage.Tests.ps1
   ```

1. Success!

   ```Powershell
   Tests completed in 6.26s
   Tests Passed: 8, Failed: 0, Skipped: 0 NotRun: 0
   ```

1. Don't forget to delete any deployed resources that are no longer needed.
