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
    $ApplicationId = Get-RequiredEnvironmentVariable AZ_APPLICATION_ID
    $TenantId = Get-RequiredEnvironmentVariable AZ_TENANT_ID
    $SubscriptionId = Get-RequiredEnvironmentVariable AZ_SUBSCRIPTION_ID
    $CurrentConnection = Get-AzContext
    $Results = [AuthenticationResult]::new()

    # If the current context matches the subscription, tenant, and service principal, then we're already properly
    # logged in.
    # More comments
    if ($null -ne $CurrentConnection `
      -and ($CurrentConnection).Account.Type -eq 'ServicePrincipal' `
      -and ($CurrentConnection).Account.Id -eq $ApplicationId `
      -and ($CurrentConnection).Tenant.Id -eq $TenantId `
      -and ($CurrentConnection).Subscription.Id -eq $SubscriptionId) {
      $Results.Success = $true
      $Results.AuthenticationData = [AuthenticationData]::new(($CurrentConnection).Subscription.Id)
    } else {
      # The current context is not correct, create the credentials and login to the correct account
      $ClientSecret = Get-RequiredEnvironmentVariable AZ_ENCRYPTED_PASSWORD | ConvertTo-SecureString
      $Credential = New-Object System.Management.Automation.PSCredential -ArgumentList $ApplicationId, $ClientSecret

      try {
        $ConnectionParams = @{
          Credential = $Credential
          TenantId = $TenantId
          Subscription = $SubscriptionId
        }
        $Connection = Connect-AzAccount -ServicePrincipal @ConnectionParams

        $Results.Success = $true
        $Results.AuthenticationData = [AuthenticationData]::new($Connection.Context.Subscription.Id)
      } catch {
        $thrownError = $_
        $Results.Success = $false
        Write-Error $thrownError
      }

      $Results
    }
  }
  End { }
}
