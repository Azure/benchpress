# INLINE_SKIP
using module ./../Classes/AuthenticationResult.psm1
using module ./../Classes/AuthenticationData.psm1

Import-Module Az

. $PSScriptRoot/../Private/Get-RequiredEnvironmentVariable.ps1
# end INLINE_SKIP

function Connect-Account {
  <#
    .SYNOPSIS
      Connect-Account uses environment variable values to log into an Azure context. This is an internal function and
      should not be used outside of the BenchPress module.

    .DESCRIPTION
      Connect-Account is designed to login to an Azure context using environment variables to login as a
      ServicePrincipal for the PowerShell session.

      The expected environment variables are:

      AZ_APPLICATION_ID - The Service Principal ID
      AZ_ENCRYPTED_PASSWORD - The Service Principal account password properly encrypted using ConvertTo-SecureString
                              and saved as an environment variable using ConvertFrom-SecureString
      AZ_TENANT_ID - The Tenant ID to login to
      AZ_SUBSCRIPTION_ID - The Subscription ID to login to

      If the current context that is logged in to matches the Service Principal, Tenant, and Subscription this function
      is a no-op.

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
    $applicationId = Get-RequiredEnvironmentVariable AZ_APPLICATION_ID
    $tenantId = Get-RequiredEnvironmentVariable AZ_TENANT_ID
    $subscriptionId = Get-RequiredEnvironmentVariable AZ_SUBSCRIPTION_ID
    $currentConnection = Get-AzContext
    $results = [AuthenticationResult]::new()

    # If the current context matches the subscription, tenant, and service principal, then we're already properly
    # logged in.
    if ($null -ne $currentConnection `
      -and ($currentConnection).Account.Type -eq 'ServicePrincipal' `
      -and ($currentConnection).Account.Id -eq $applicationId `
      -and ($currentConnection).Tenant.Id -eq $tenantId `
      -and ($currentConnection).Subscription.Id -eq $subscriptionId) {
      $results.Success = $true
      $results.AuthenticationData = [AuthenticationData]::new(($currentConnection).Subscription.Id)
    } else {
      # The current context is not correct, create the credentials and login to the correct account
      $clientSecret = Get-RequiredEnvironmentVariable AZ_ENCRYPTED_PASSWORD | ConvertTo-SecureString
      $clientSecret = New-Object System.Management.Automation.PSCredential -ArgumentList $applicationId, $clientSecret

      try {
        $connectionParams = @{
          Credential   = $clientSecret
          TenantId     = $tenantId
          Subscription = $subscriptionId
        }
        $connection = Connect-AzAccount -ServicePrincipal @connectionParams

        $results.Success = $true
        $results.AuthenticationData = [AuthenticationData]::new($connection.Context.Subscription.Id)
      } catch {
        $thrownError = $_
        $results.Success = $false
        Write-Error $thrownError
      }

      $results
    }
  }
  End { }
}
