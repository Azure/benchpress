# How To Run Synapse.Tests.ps1

`Synapse.Tests.ps1` contains examples of using the `Confirm-AzBPSynapseWorkspace`, `Confirm-AzBPSynapseSparkPool`,
and `Confirm-AzBPSynapseSqlPool` cmdlet.

## Pre-Requisites

- Follow the [setup instructions](../README.md)

## Steps

1. Navigate to Synapse directory:

   ```Powershell
   cd examples\Synapse\
   ```

1. Deploy the SQL Database to your resource group:

   ```Powershell
    New-AzResourceGroupDeployment -ResourceGroupName "<your-resource-group-name>"`
    -TemplateFile ".\synapse.bicep"
   ```

1. When prompted in your terminal, set the `synapse_sqlpool_admin_password` parameter with your own password.

1. Update `Synapse.Tests.ps1` variables to point to your expected resources:

   - `rg-test` -> `your-resource-group-name`
   - `westus3` -> `your-synapse-location`
   - `samplesynws` -> `your-synapse-workspace-name`
   - `samplespark` -> `your-spark-pool-name`
   - `samplesql` -> `your-sql-pool-name`

1. If using a local copy of `Az-InfrastructureTest`, replace `Import-Module Az-InfrastructureTest` with
`Import-Module "../../bin/BenchPress.Azure.psd1"`.

1. Run `Synapse.Tests.ps1`:

   ```Powershell
   Invoke-Pester -Path .\Synapse.Tests.ps1
   ```

1. Success!

   ```Powershell
   Tests completed in 4.43s
   Tests Passed: 4, Failed: 0, Skipped: 0 NotRun: 0
   ```

1. Don't forget to delete any deployed resources that are no longer needed.

## Troubleshooting

If you run into role assignment errors, you'll need to either:

1. Make sure the Service Principal you use to deploy has a role assignment in the azure portal as an owner.

1. Use `Connect-AzAccount` if you have credentials as an owner to the subscription.
