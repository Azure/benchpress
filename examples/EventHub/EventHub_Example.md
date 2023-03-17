# How To Run EventHub.Tests.ps1

`EventHub.Tests.ps1` contains examples of using the `Confirm-AzBPEventHub`, `Confirm-AzBPEventHubConsumerGroup`,
and `Confirm-AzBPEventHubNamespace` cmdlet.

## Pre-Requisites

- Follow the [setup instructions](../README.md)

## Steps

1. Navigate to EventHub directory:

   ```Powershell
   cd examples\EventHub\
   ```

1. Deploy the EventHub to your resource group:

   ```Powershell
    New-AzResourceGroupDeployment -ResourceGroupName "<your-resource-group-name>"`
    -TemplateFile ".\eventHub.bicep"
   ```

1. Update `EventHub.Tests.ps1` variables to point to your expected resources:

   - `rg-test` -> `your-resource-group-name`
   - `eventhubtest` -> `your-eventhub-name`
   - `samplenamespace` -> `your-eventhub-namespace-name`
   - `eventhubconsumergrouptest` -> `your-eventhub-consumer-group-name`

1. If using a local copy of `Az.InfrastructureTesting`, replace `Import-Module Az.InfrastructureTesting` with
`Import-Module "../../bin/BenchPress.Azure.psd1"`.

1. Run `EventHub.Tests.ps1`:

   ```Powershell
   Invoke-Pester -Path .\EventHub.Tests.ps1
   ```

1. Success!

   ```Powershell
   Tests completed in 952ms
   Tests Passed: 4, Failed: 0, Skipped: 0 NotRun: 0
   ```

1. Don't forget to delete any deployed resources that are no longer needed.
