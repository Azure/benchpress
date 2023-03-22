# How To Run VirtualMachine.Tests.ps1

`VirtualMachine.Tests.ps1` contains examples of using the `Confirm-AzBPVirtualMachine` cmdlet.

## Pre-Requisites

- Follow the [setup instructions](../README.md)

## Steps

1. Navigate to VirtualMachine directory:

   ```Powershell
   cd examples\VirtualMachine\
   ```

1. Deploy the Virtual Machine to your resource group:

   ```Powershell
    New-AzResourceGroupDeployment -ResourceGroupName "<your-resource-group-name>"`
    -TemplateFile ".\virtualMachine.bicep"
   ```

1. When prompted in your terminal, set the `adminPasswordOrKey` parameter with your own password.

1. Update `VirtualMachine.Tests.ps1` variables to point to your expected resources:

   - `rg-test`        -> `your-resource-group-name`
   - `westus3`        -> `your-resource-group-location`
   - `simpleLinuxVM1` -> `your-virtual-machine-name`

1. If using a local copy of `Az.InfrastructureTesting`, replace `Import-Module Az.InfrastructureTesting` with
`Import-Module "../../bin/BenchPress.Azure.psd1"`. Note that the final step in each Pester test is to execute a
`Remove-Module`. The test is setup so that regardless of which method is chosen to load the module it will be properly
removed after the Pester tests have run.

1. Run `VirtualMachine.Tests.ps1`:

   ```Powershell
   Invoke-Pester -Path .\VirtualMachine.Tests.ps1
   ```

1. Success!

   ```Powershell
   Tests completed in 952ms
   Tests Passed: 2, Failed: 0, Skipped: 0 NotRun: 0
   ```

1. Don't forget to delete any deployed resources that are no longer needed.
