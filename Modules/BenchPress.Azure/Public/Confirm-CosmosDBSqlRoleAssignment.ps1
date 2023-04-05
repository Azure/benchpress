# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-CosmosDBSqlRoleAssignment {
  <#
    .SYNOPSIS
      Confirms that a CosmosDB Sql Role Assignment exists.

    .DESCRIPTION
      The Confirm-AzBPCosmosDBSqlRoleAssignment cmdlet gets the list of all existing CosmosDB Sql Role Assignments
      given the Resource Group Name, the name of the Cosmos DB Account, and the name of the Role Assignment Id.

    .PARAMETER ResourceGroupName
      The name of the Resource Group. The name is case insensitive.

    .PARAMETER AccountName
      The name of the Cosmos DB Account.

    .PARAMETER RoleAssignmentId
      The Id of the Role Assignment.

    .EXAMPLE
      $params = @{
        ResourceGroupName = "rgbenchpresstest"
        AccountName = "an"
        RoleAssignmentId = "roleassignmentid"
      }

      Confirm-AzBPCosmosDBSqlRoleAssignment @params

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory=$true)]
    [string]$AccountName,

    [Parameter(Mandatory=$true)]
    [string]$RoleAssignmentId
  )
  Begin {
    $connectResults = Connect-Account
  }
  Process {
    $params = @{
      ResourceGroupName = $ResourceGroupName
      AccountName = $AccountName
      Id = $RoleAssignmentId
    }
    $resource = Get-AzCosmosDBSqlRoleAssignment @params

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
