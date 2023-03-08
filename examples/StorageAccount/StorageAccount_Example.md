# How To Run StorageAccount.Tests.ps1

`StorageAccount.Tests.ps1` contains examples of using the `Confirm-AzBPStorageAccount` cmdlet.

## Pre-Requisites

- Follow the [setup instructions](../README.md)

## Steps

1. Navigate to StorageAccount directory:

   ```Powershell
   cd examples\StorageAccount\
   ```

1. Deploy the Storage Account to your resource group:

   ```Powershell
    New-AzResourceGroupDeployment -ResourceGroupName "<your-resource-group-name>"`
    -TemplateFile ".\storageAccount.bicep"
   ```

1. Update `StorageAccount.Tests.ps1` variables to point to your expected resources:

   - `rg-test` -> `your-resource-group-name`
   - `azbenchpressstorage` -> `your-storage-account-name`

1. If using a local copy of `Az-InfrastructureTest`, replace `Import-Module Az-InfrastructureTest` with
`Import-Module "../../bin/BenchPress.Azure.psd1"`.

1. Run `StorageAccount.Tests.ps1`:

   ```Powershell
   Invoke-Pester -Path .\StorageAccount.Tests.ps1
   ```

1. Success!

   ```Powershell
   Tests completed in 952ms
   Tests Passed: 2, Failed: 0, Skipped: 0 NotRun: 0
   ```

1. Don't forget to delete any deployed resources that are no longer needed.
