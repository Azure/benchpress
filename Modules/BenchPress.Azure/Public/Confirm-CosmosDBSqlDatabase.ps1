# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-CosmosDBSqlDatabase {
  <#
    .SYNOPSIS
      Confirms that a Cosmos DB SQL Database exists.

    .DESCRIPTION
      The Confirm-AzBPCosmosDBSqlDatabase cmdlet gets a Cosmos DB SQL Database using the specified Resource Group,
      Cosmos DB Account, and SQL Database names.

    .PARAMETER ResourceGroupName
      The name of the Resource Group. The name is case insensitive.

    .PARAMETER AccountName
      The name of the Cosmos DB Account.

    .PARAMETER Name
      The name of the Cosmos DB SQL Database.

    .EXAMPLE
      Confirm-AzBPCosmosDBSqlDatabase  -ResourceGroupName "rgbenchpresstest" -AccountName "an" -Name "sqldb"

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
    $resource = Get-AzCosmosDBSqlDatabase -ResourceGroupName $ResourceGroupName -AccountName $AccountName -Name $Name

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
