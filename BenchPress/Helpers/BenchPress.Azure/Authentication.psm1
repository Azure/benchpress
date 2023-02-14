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
    None
#>
function Connect-Account {
  [OutputType([System.Void])]
  param ( )
  Begin {
    $ApplicationId = Get-RequiredEnvironmentVariable AZ_APPLICATION_ID
    $TenantId = Get-RequiredEnvironmentVariable AZ_TENANT_ID
    $SubscriptionId = Get-RequiredEnvironmentVariable AZ_SUBSCRIPTION_ID
    $CurrentConnection = Get-AzContext
  }
  Process {
    # If the current context matches the subscription, tentant, and service principal, then we're already properly
    # logged in.
    if ($null -ne $CurrentConnection `
      -and ($CurrentConnection).Account.Type -eq 'ServicePrincipal' `
      -and ($CurrentConnection).Account.Id -eq $ApplicationId `
      -and ($CurrentConnection).Tenant.Id -eq $TenantId `
      -and ($CurrentConnection).Subscription.Id -eq $SubscriptionId) {
      return
    }

    # The current context is not correct, create the credentials and login
    $ClientSecret = Get-RequiredEnvironmentVariable AZ_ENCRYPTED_PASSWORD | ConvertTo-SecureString
    $Credential = `
      New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $ApplicationId, $ClientSecret
    Connect-AzAccount -ServicePrincipal -Credential $Credential -TenantId $TenantId -Subscription $SubscriptionId
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


