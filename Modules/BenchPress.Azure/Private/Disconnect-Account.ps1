Import-Module Az

function Disconnect-Account {
  <#
    .SYNOPSIS
      Disconnect-Account uses environment variable values to disconnect from a specific Azure context. This is an
      internal function and should not be used outside of the BenchPress module.

    .DESCRIPTION
      Disconnect-Account is designed to automatically log out of the specific Azure context using environment variables
      to identify the context to disconnect.

      The expected environment variables are:

      AZ_APPLICATION_ID - The Service Principal ID
      AZ_TENANT_ID - The Tenant ID to login to
      AZ_SUBSCRIPTION_ID - The Subscription ID to login to

      If the current context does not match the Service Principal, Tenant, or Subscription then this function is a
      no-op

    .EXAMPLE
      There is only one way to call Disconnect-Account:

      Disconnect-Account

    .INPUTS
      None

    .OUTPUTS
      None
  #>
  [OutputType([System.Void])]
  [CmdletBinding()]
  param ( )
  Begin {
    $ApplicationId = Get-RequiredEnvironmentVariable AZ_APPLICATION_ID
    $TenantId = Get-RequiredEnvironmentVariable AZ_TENANT_ID

    # If the current context doesn't match the target subscription, tentant, and client, then the testing account is
    # not logged in. Do nothing.
    $CurrentConnection = Get-AzContext
  }
  Process {
    if ($null -eq $CurrentConnection `
      -or ($CurrentConnection).Account.Type -ne "ServicePrincipal" `
      -or ($CurrentConnection).Account.Id -ne $ApplicationId `
      -or ($CurrentConnection).Tenant.Id -ne $TenantId) {
      return
    }

    $CurrentConnection | Disconnect-AzAccount -Scope CurrentUser
  }
  End { }
}
