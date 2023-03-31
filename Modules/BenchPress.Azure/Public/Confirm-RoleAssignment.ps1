# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-RoleAssignment {
  <#
    .SYNOPSIS
      Confirms that a Role Assignment for a service principal exists.

    .DESCRIPTION
      The Confirm-AzBPRoleAssignment cmdlet gets a Role Assignment using the specified Service Prinicpal, Scope
      and Role Assignment name.

    .PARAMETER RoleDefinitionName
      The name of the role definition i.e. Reader, Contributor etc.

    .PARAMETER ServicePrincipalId
      The service principal app id

    .PARAMETER Scope
      The scope of the role assignment. In the format of relative URI. For e.g.
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
    $ConnectResults = Connect-Account
  }
  Process {
    $params = @{
      ServicePrincipalName = $ServicePrincipalId
      RoleDefinitionName   = $RoleDefinitionName
      Scope                = $Scope
    }

    # Filter to specific scope specified by the parameter
    $Resource = Get-AzRoleAssignment @params | Where-Object Scope -eq $Scope

    [ConfirmResult]::new($Resource, $ConnectResults.AuthenticationData)
  }
  End { }
}