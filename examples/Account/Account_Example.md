# How To Run Account.Tests.ps1

`Account.Tests.ps1` contains examples of using the `Confirm-AzBPAccount` cmdlet.

## Pre-Requisites

- Follow the [setup instructions](../README.md)

## Steps

1. Navigate to Account directory:

   ```Powershell
   cd examples\Account\
   ```

1. Run `Account.Tests.ps1`:

   ```Powershell
   Invoke-Pester -Path .\Account.Tests.ps1
   ```

1. Success!

   ```Powershell
   Tests completed in 952ms
   Tests Passed: 2, Failed: 0, Skipped: 0 NotRun: 0
   ```
