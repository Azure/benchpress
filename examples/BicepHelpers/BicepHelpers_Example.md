# How To Run BicepHelpers.Tests.ps1

`BicepHelpers.Tests.ps1` contains examples of using the `Deploy-AzBPBicepFeature` and `Remove-AzBPBicepFeature` cmdlet.

## Pre-Requisites

- Follow the [setup instructions](../README.md)

## Steps

1. Navigate to BicepHelpers directory:

   ```Powershell
   cd examples\BicepHelpers\
   ```

1. Update `BicepHelpers.Tests.ps1` variables to point to your resource group:

   - `rg-test` -> `your-resource-group-name`

1. If using a local copy of `Az-InfrastructureTest`, replace `Import-Module Az-InfrastructureTest` with
`Import-Module "../../bin/BenchPress.Azure.psd1"`.

1. (Optional) Uncomment the `Remove-AzBPBicepFeature` line in `BicepHelpers.Tests.ps1`. **Warning**: this will delete
your resource group.

1. Run `BicepHelpers.Tests.ps1`:

   ```Powershell
   Invoke-Pester -Path .\BicepHelpers.Tests.ps1
   ```

1. Success!

   ```Powershell
   Tests completed in 16.45s
   Tests Passed: 1, Failed: 0, Skipped: 0 NotRun: 0
   ```

1. Don't forget to delete any deployed resources that are no longer needed.

1. (Optional) You can also run checks on your bicep file prior to deploying using `Confirm-AzBPBicepFile`. Force a
linting error in `../ActionGroup/actionGroup.bicep` by hardcoding the location on line 8:

   ```bicep
   location: "global"
   ```

   - Execute `Confirm-AzBPBicepFile -BicepFilePath "../ActionGroup/actionGroup.bicep"` in your terminal and receive
     the following errors:

     ```Powershell
     Error no-unused-params: Parameter "location" is declared but never used.
       [https://aka.ms/bicep/linter/no-unused-params]
     ```
