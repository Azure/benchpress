# How To Run RoleAssignment.Tests.ps1

`RoleAssignment.Tests.ps1` contains examples of using the `Confirm-AzBPRoleAssignment` cmdlet.
Role assignments in Azure do not belong to a location or a resource group, so the example tests
do not check for this.

## Pre-Requisites

- Follow the [setup instructions](../README.md)

## Steps

1. Navigate to RoleAssignment directory:

   ```Powershell
   cd examples\RoleAssignment\
   ```

1. Deploy the Role Assignment to your subscription:
  You will need Owner permission or higher.

   ```Powershell
    New-AzSubscriptionDeployment -TemplateFile ".\roleAssignment.bicep" `
    -Location "WestUS3"
   ```

1. When prompted in your terminal, set the `svcPrincipalObjectId` parameter with your service principal's
   enterprise/managed application object ID.

1. Update `RoleAssignment.Tests.ps1` variables to point to your expected resources:

   - `sampleappid`       -> `your-svc-principal-object-id (the same object id from step 3)`
   - `/subscriptions/id` -> `your-scope`
   - `Reader`            -> `your-role-name`

1. If using a local copy of `Az.InfrastructureTesting`, replace `Import-Module Az.InfrastructureTesting` with
`Import-Module "../../bin/BenchPress.Azure.psd1"`. Note that the final `AfterAll` step will properly remove the module
regardless of which method is chosen to load the module.

1. Run `RoleAssignment.Tests.ps1`:

   ```Powershell
   Invoke-Pester -Path .\RoleAssignment.Tests.ps1
   ```

1. Success!

   ```Powershell
   Tests completed in 952ms
   Tests Passed: 2, Failed: 0, Skipped: 0 NotRun: 0
   ```

1. Don't forget to delete any deployed resources that are no longer needed.
