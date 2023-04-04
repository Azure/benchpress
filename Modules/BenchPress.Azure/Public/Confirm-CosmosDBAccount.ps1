# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-CosmosDBAccount {
  <#
    .SYNOPSIS
      Confirms that a Cosmos DB Account exists.

    .DESCRIPTION
      The Confirm-AzBPCosmosDBAccount cmdlet gets a Cosmos DB Account using the specified Resource Group and Cosmos DB
      Account names.

    .PARAMETER ResourceGroupName
      The name of the Resource Group. The name is case insensitive.

    .PARAMETER Name
      The name of the Cosmos DB Account.

    .EXAMPLE
      Confirm-AzBPCosmosDBAccount -Name "benchpresstest" -ResourceGroupName "rgbenchpresstest"

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
    [string]$Name
  )
  Begin {
    $connectResults = Connect-Account
  }
  Process {
    $resource = Get-AzCosmosDBAccount -ResourceGroupName $ResourceGroupName -Name $Name

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
