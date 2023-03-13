# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-CosmosDBSqlDatabase {
  <#
    .SYNOPSIS
      Confirms that a Cosmos DB SQL Database exists.

    .DESCRIPTION
      The Confirm-AzBPCosmosDBSqlDatabase cmdlet gets Cosmos DB Gremlin database given the Resource Group Name, the
      name of the Cosmos DB Account, and the name of the SQL Database.

    .PARAMETER ResourceGroupName
      The name of the Resource Group.

    .PARAMETER AccountName
      The Cosmos DB account name.

    .PARAMETER Name
      The name of the Cosmos DB SQL Database

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
    $ConnectResults = Connect-Account
  }
  Process {
    $Resource = Get-AzCosmosDBSqlDatabase -ResourceGroupName $ResourceGroupName -AccountName $AccountName -Name $Name

    [ConfirmResult]::new($Resource, $ConnectResults.AuthenticationData)
  }
  End { }
}
