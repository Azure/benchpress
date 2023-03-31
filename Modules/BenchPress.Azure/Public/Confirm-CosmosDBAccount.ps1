# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-CosmosDBAccount {
  <#
    .SYNOPSIS
      Confirms that a Cosmos DB Account exists.

    .DESCRIPTION
      The Confirm-AzBPCosmosDBAccount cmdlet gets Cosmos DB Account given the Resource Group Name and the name of the
      Cosmos DB Account.

    .PARAMETER ResourceGroupName
      The name of the Resource Group.

    .PARAMETER Name
      The Cosmos DB account name.

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
