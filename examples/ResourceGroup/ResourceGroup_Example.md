# How To Run ResourceGroup.Tests.ps1

`ResourceGroup.Tests.ps1` contains examples of using the `Confirm-AzBPResourceGroup` cmdlet.

## Pre-Requisites

- Follow the [setup instructions](../README.md)

## Steps

1. Navigate to ResourceGroup directory:

   ```Powershell
   cd examples\ResourceGroup\
   ```

1. Deploy the Resource Group to your subscription:

   ```Powershell
    New-AzSubscriptionDeployment -TemplateFile ".\resourceGroup.bicep" `
    -Location "WestUS3"
   ```

1. Update `ResourceGroup.Tests.ps1` variables to point to your expected resources:

   - `rg-test`  -> `your-resource-group-name`
   - `westus3`  -> `your-resource-group-location`

1. If using a local copy of `BenchPress.Azure`, replace `Import-Module BenchPress.Azure` with
`Import-Module "../../bin/BenchPress.Azure.psd1"`. Note that the final `AfterAll` step will properly remove the module
regardless of which method is chosen to load the module.

1. Run `ResourceGroup.Tests.ps1`:

   ```Powershell
   Invoke-Pester -Path .\ResourceGroup.Tests.ps1
   ```

1. Success!

   ```Powershell
   Tests completed in 952ms
   Tests Passed: 2, Failed: 0, Skipped: 0 NotRun: 0
   ```

1. Don't forget to delete any deployed resources that are no longer needed.
