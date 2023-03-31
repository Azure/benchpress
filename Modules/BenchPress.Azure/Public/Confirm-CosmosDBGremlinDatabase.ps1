# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-CosmosDBGremlinDatabase {
  <#
    .SYNOPSIS
      Confirms that a Cosmos DB Gremlin Database exists.

    .DESCRIPTION
      The Confirm-AzBPCosmosDBGremlinDatabase cmdlet gets Cosmos DB Gremlin database given the Resource Group Name, the
      name of the Cosmos DB Account, and the name of the Gremlin Database.

    .PARAMETER ResourceGroupName
      The name of the Resource Group.

    .PARAMETER AccountName
      The Cosmos DB account name.

    .PARAMETER Name
      The name of the Cosmos DB Gremlin Database

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
