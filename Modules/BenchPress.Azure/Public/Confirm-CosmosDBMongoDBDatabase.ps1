# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-CosmosDBMongoDBDatabase {
  <#
    .SYNOPSIS
      Confirms that a Cosmos DB Mongo DB Database exists.

    .DESCRIPTION
      The Confirm-CosmosDBMongoDBDatabase cmdlet gets Cosmos DB Mongo DB database given the Resource Group Name, the
      name of the Cosmos DB Account, and the name of the Mongo DB Database.

    .PARAMETER ResourceGroupName
      The name of the Resource Group.

    .PARAMETER AccountName
      The Cosmos DB account name.

    .PARAMETER Name
      The name of the Cosmos DB Mongo DB Database

    .EXAMPLE
      Confirm-AzBPCosmosDBMongoDBDatabase  -ResourceGroupName "rgbenchpresstest" -AccountName "an" -Name "mongodbdb"

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
    $params = @{
      ResourceGroupName = $ResourceGroupName
      AccountName       = $AccountName
      Name              = $Name
    }
    $Resource = Get-AzCosmosDBMongoDBDatabase @params

    [ConfirmResult]::new($Resource, $ConnectResults.AuthenticationData)
  }
  End { }
}
