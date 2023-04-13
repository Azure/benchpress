# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-RoleAssignment {
  <#
    .SYNOPSIS
      Confirms that a Role Assignment for a service principal exists.

    .DESCRIPTION
      The Confirm-AzBPRoleAssignment cmdlet gets a Role Assignment using the specified Service Prinicpal, Scope,
      and Role Assignment names.

    .PARAMETER RoleDefinitionName
      The name of the Role Definition i.e. Reader, Contributor etc.

    .PARAMETER ServicePrincipalId
      The Enterprise/Managed Application Object ID of the Service Principal.

    .PARAMETER Scope
      The Scope of the Role Assignment. In the format of relative URI. For e.g.
      /subscriptions/{id}/resourceGroups/{resourceGroupName}.
      It must start with "/subscriptions/{id}".

    .EXAMPLE
      Confirm-AzBPRoleAssignment -RoleDefinitionName Reader -ServicePrincipalName testId `
      -Scope /subscriptions/{id}/resourceGroups/{resourceGroupName}

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$RoleDefinitionName,

    [Parameter(Mandatory=$true)]
    [string]$ServicePrincipalId,

    [Parameter(Mandatory=$true)]
    [ValidatePattern("/subscriptions/.*")]
    [string]$Scope
  )
  Begin {
    $connectResults = Connect-Account
  }
  Process {
    $params = @{
      ObjectId           = $ServicePrincipalId
      RoleDefinitionName = $RoleDefinitionName
      Scope              = $Scope
    }

    # Filter to specific scope specified by the parameter
    $resource = Get-AzRoleAssignment @params | Where-Object Scope -eq $Scope

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
