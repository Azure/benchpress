using module ./public/classes/AuthenticationResult.psm1
using module ./public/classes/AuthenticationData.psm1

<#
  .SYNOPSIS
    Get-RequiredEnvironmentVariable is a private helper method that retrieves environment variables with the
    expectation that if they are not present that an error will be logged with an immedate exit.

  .DESCRIPTION
    Get-RequiredEnvironmentVariable retrieves the environment variable specified by the input parameter and checks to
    be sure that a value is present for that environment variable. If the value is missing or whitespace a message will
    be written to Write-Error with the name of the variable in the output and exit will be called.

  .PARAMETER VariableName
    This is the name of the environment variable to retrieve and validate that a value is present.

  .EXAMPLE
    Provide -VariableName Parameter

    Get-RequiredEnvironmentVariable -VariableName AZ_APPLICATION_ID

  .EXAMPLE
    Provide variable name without -VariableName Parameter

    Get-RequiredEnvironmentVariable AZ_APPLICATION_ID

  .INPUTS
    System.String

  .OUTPUTS
    System.String
#>
function Get-RequiredEnvironmentVariable {
  [OutputType([System.String])]
  param (
    [Parameter(Mandatory=$true, Position=0)]
    [string]$VariableName
  )
  Begin {
    $Value = [string]$null
  }
  Process {
    $Value = [System.Environment]::GetEnvironmentVariable($VariableName)

    if ([string]::IsNullOrWhiteSpace($Value)) {
      Write-Error("Missing Required Environment Variable $VariableName")
      exit 1
    }
  }
  End {
    return $Value
  }
}

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
      AZ_ENCRYPTED_PASSWORD - The Service Principal account password properly encrypted using ConvertTo-SecureString and
                              saved as an environment variable using ConvertFrom-SecureString
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
        $Results.AuthenticationData = [AuthenticationData]::new()
        $Results.AuthenticationData.SubscriptionId = $Connection.Context.Subscription.Id
      } catch {
        $Exception = $_
        $Results.Error = $Exception
        $Results.Success = $false
      }

      $Results
    }
  }
  End { }
}

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

    If the current context does not match the Service Principal, Tenant, or Subscription then this function is a no-op

  .EXAMPLE
    There is only one way to call Disconnect-Account:

    Disconnect-Account

  .INPUTS
    None

  .OUTPUTS
    None
#>
function Disconnect-Account {
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

Export-ModuleMember -Function Connect-Account, Disconnect-Account
