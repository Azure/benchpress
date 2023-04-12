# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-CosmosDBGremlinDatabase {
  <#
    .SYNOPSIS
      Confirms that a Cosmos DB Gremlin Database exists.

    .DESCRIPTION
      The Confirm-AzBPCosmosDBGremlinDatabase cmdlet gets a Cosmos DB Gremlin Database using the specified Resource
      Group, Cosmos DB Account, and Gremlin Database names.

    .PARAMETER ResourceGroupName
      The name of the Resource Group. The name is case insensitive.

    .PARAMETER AccountName
      The name of the Cosmos DB Account.

    .PARAMETER Name
      The name of the Cosmos DB Gremlin Database.

    .EXAMPLE
      Confirm-AzBPCosmosDBGremlinDatabase -ResourceGroupName "rgbenchpresstest" -AccountName "an" -Name "gremlindb"

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
    [string]$Name
  )
  Begin {
    $connectResults = Connect-Account
  }
  Process {
    $params = @{
      ResourceGroupName = $ResourceGroupName
      AccountName       = $AccountName
      Name              = $Name
    }
    $resource = Get-AzCosmosDBGremlinDatabase @params

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
