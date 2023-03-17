# How To Run StreamAnalytics.Tests.ps1

`StreamAnalytics.Tests.ps1` contains examples of using the `Confirm-AzBPStreamAnalyticsCluster`,
`Confirm-AzBPStreamAnalyticsFunction`, `Confirm-AzBPStreamAnalyticsInput`, `Confirm-AzBPStreamAnalyticsJob`,
`Confirm-AzBPStreamAnalyticsOutput`,and `Confirm-AzBPStreamAnalyticsTransformation` cmdlets.

## Pre-Requisites

- Follow the [setup instructions](../README.md)

## Steps

1. Navigate to StreamAnalytics directory:

   ```Powershell
   cd examples\StreamAnalytics\
   ```

1. Deploy the StreamAnalytics Cluster to your resource group:

   ```Powershell
    New-AzResourceGroupDeployment -ResourceGroupName "<your-resource-group-name>"`
    -TemplateFile ".\streamAnalytics.bicep"
   ```

1. Update `StreamAnalytics.Tests.ps1` variables to point to your expected resources:

<<<<<<< HEAD
   - `rg-test`            -> `your-resource-group-name`
   - `teststreamcluster`  -> `your-stream-analytics-cluster-name`
   - `testjob`            -> `your-stream-analytics-job-name`
   - `testfunction`       -> `your-stream-analytics-function-name`
   - `testinput`          -> `your-stream-analytics-input-name`
   - `testoutput`         -> `your-stream-analytics-output-name`
   - `testtransformation` -> `your-stream-analytics-transformation-name`
   - `westus3`            -> `your-location-of-your-cluster`

1. If using a local copy of `Az-InfrastructureTesting`, replace `Import-Module Az-InfrastructureTesting` with
=======
   - `rg-test` -> `your-resource-group-name`
   - `teststreamcluster` -> `your-stream-analytics-cluster-name`
   - `westus3` -> `your-location-of-your-cluster`

1. If using a local copy of `Az-InfrastructureTest`, replace `Import-Module Az-InfrastructureTest` with
>>>>>>> origin
`Import-Module "../../bin/BenchPress.Azure.psd1"`.

1. Run `StreamAnalytics.Tests.ps1`:

   ```Powershell
   Invoke-Pester -Path .\StreamAnalytics.Tests.ps1
   ```

1. Success!

   ```Powershell
   Tests completed in 6.26s
   Tests Passed: 8, Failed: 0, Skipped: 0 NotRun: 0
   ```

1. Don't forget to delete any deployed resources that are no longer needed.
