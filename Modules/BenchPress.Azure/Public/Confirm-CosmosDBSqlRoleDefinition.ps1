# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-CosmosDBSqlRoleDefinition {
  <#
    .SYNOPSIS
      Confirms that a CosmosDB Sql Role Definition exists.

    .DESCRIPTION
      The Confirm-AzBPCosmosDBSqlRoleDefinition cmdlet gets a CosmosDB Sql Role Definition
      using the specified Resource Group Name, Cosmos DB Account Name and Role Definition Id.

    .PARAMETER ResourceGroupName
      The name of the Resource Group. The name is case insensitive.

    .PARAMETER AccountName
      The name of the Cosmos DB Account.

    .PARAMETER RoleDefinitionId
      The Id of the Role Definition.

    .EXAMPLE
      $params = @{
        ResourceGroupName = "rgbenchpresstest"
        AccountName = "an"
        RoleDefinitionId = "roledefinitionid"
      }

      Confirm-AzBPCosmosDBSqlRoleDefinition @params

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
    [string]$RoleDefinitionId
  )
  Begin {
    $connectResults = Connect-Account
  }
  Process {
    $params = @{
      ResourceGroupName = $ResourceGroupName
      AccountName = $AccountName
      Id = $RoleDefinitionId
    }
    $resource = Get-AzCosmosDBSqlRoleDefinition @params

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
