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

1. Deploy the resources (VM) to your resource group:

   ```Powershell
    New-AzResourceGroupDeployment -ResourceGroupName "<your-resource-group-name>"`
    -TemplateFile ".\common.bicep"
   ```

1. When prompted in your terminal, set the `vmAdminPasswordOrKey` with your own password.

1. Update `Common.Tests.ps1` variables to point to your expected resources:

   - `rg-test` -> `your-resource-group-name`
   - `testvm`  -> `your-virtual-machine-name`

1. If using a local copy of `Az.InfrastructureTesting`, replace `Import-Module Az.InfrastructureTesting` with
`Import-Module "../../bin/BenchPress.Azure.psd1"`. Note that the final `AfterAll` step will properly remove the module
regardless of which method is chosen to load the module.

1. Run `Common.Tests.ps1`:

   ```Powershell
   Invoke-Pester -Path .\Common.Tests.ps1
   ```

1. Success!

   ```Powershell
   Tests completed in 7.78s
   Tests Passed: 3, Failed: 0, Skipped: 0 NotRun: 0
   ```

1. Don't forget to delete any deployed resources that are no longer needed.
