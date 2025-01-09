# INLINE_SKIP
using module ./../Classes/AuthenticationResult.psm1
using module ./../Classes/AuthenticationData.psm1

Import-Module Az

. $PSScriptRoot/../Private/Get-EnvironmentVariable.ps1
# end INLINE_SKIP

function Connect-Account {
  <#
    .SYNOPSIS
      Connect-Account uses environment variable values to log into an Azure context. This is an internal function and should not be used outside of the BenchPress module.

    .DESCRIPTION
      Connect-Account is designed to login to an Azure context using environment variables to login as a ServicePrincipal for the PowerShell session.

      The expected environment variables are:
      AZ_USE_MANAGED_IDENTITY - If set to "true", BenchPress will login to Azure using a Managed Identity
      AZ_SUBSCRIPTION_ID - The Subscription ID to login to

      The following Environment variables are required if not using Managed Identity.
      AZ_APPLICATION_ID - The Service Principal ID
      AZ_ENCRYPTED_PASSWORD - The Service Principal account password properly encrypted using ConvertTo-SecureString and saved as an environment variable using ConvertFrom-SecureString
      AZ_TENANT_ID - The Tenant ID to login to

      If the current context that is logged in to matches the Service Principal, Tenant, and Subscription this function is a no-op.

    .EXAMPLE
      There is only one way to call Connect-Account:

      Connect-Account

    .INPUTS
      None

    .OUTPUTS
      AuthenticationResult
  #>
  [OutputType([AuthenticationResult])]
  [CmdletBinding()]
  param ( )
  Begin { }
  Process {
    $useManagedIdentity = Get-EnvironmentVariable AZ_USE_MANAGED_IDENTITY -DontThrowIfMissing
    $subscriptionId = Get-EnvironmentVariable AZ_SUBSCRIPTION_ID -DontThrowIfMissing
    $applicationId = Get-EnvironmentVariable AZ_APPLICATION_ID -DontThrowIfMissing
    $tenantId = Get-EnvironmentVariable AZ_TENANT_ID -DontThrowIfMissing

    $currentConnection = Get-AzContext
    $results = [AuthenticationResult]::new()

    if (IsCurrentAccountLoggedIn($currentConnection)) {
      $results.Success = $true
      $results.AuthenticationData = [AuthenticationData]::new(($currentConnection).Subscription.Id)
    }
    else {
      # Login Using Managed Identity
      if ($useManagedIdentity) {
        $connection = Connect-AzAccount -Identity
        $subscriptionName = (Get-AzSubscription -SubscriptionId  $subscriptionId).Name
        Set-AzContext -Subscription $subscriptionName

        $results.Success = $true
        $results.AuthenticationData = [AuthenticationData]::new($connection.Context.Subscription.Id)
      }
      else {
          # The current context is not correct
          # Create the credentials and login to the correct account
          $clientSecret = Get-EnvironmentVariable AZ_ENCRYPTED_PASSWORD | ConvertTo-SecureString
          $clientSecret = New-Object System.Management.Automation.PSCredential -ArgumentList $applicationId, $clientSecret

          if ($currentConnection -ne $null){
            Write-Warning "Logging out of current Az.Powershell context and connecting to Subscription: $subscriptionId"
          }

          try {
            $connectionParams = @{
              Credential   = $clientSecret
              TenantId     = $tenantId
              Subscription = $subscriptionId
            }
            $connection = Connect-AzAccount -ServicePrincipal @connectionParams

            $results.Success = $true
            $results.AuthenticationData = [AuthenticationData]::new($connection.Context.Subscription.Id)
          }
          catch {
            $thrownError = $_
            $results.Success = $false
            Write-Error $thrownError
          }
      }
    }

    $results
  }
  End { }
}

function IsCurrentAccountLoggedIn($currentConnection) {
  if ($null -eq $currentConnection) {
    return $False
  }

  if ($subscriptionId -eq $null -or $applicationId -eq $null -or $tenantId -eq $null) {
    return $True
  }

  if ($currentConnection.Account.Id -eq $applicationId `
      -and $currentConnection.Tenant.Id -eq $tenantId `
      -and $currentConnection.Subscription.Id -eq $subscriptionId) {
    return $True
  }

  return $False
}
