# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-AksNodePool {
  <#
    .SYNOPSIS
      Confirms that an AKS Node Pool exists.

    .DESCRIPTION
      The Confirm-AzBPAksNodePool cmdlet gets an AKS Node Pool using the specified AKS Node Pool and Resource Group names.

    .PARAMETER ResourceGroupName
      The name of the Resource Group.

    .PARAMETER ClusterName
      The name of the Managed Cluster.

    .PARAMETER Name
      The name of the Node Pool

    .EXAMPLE
      Confirm-AzBPAksNodePool -ResourceGroupName "rgbenchpresstest" -ClusterName "clustertest" -Name "benchpresstest"

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
    [string]$ClusterName,

    [Parameter(Mandatory=$true)]
    [string]$Name
  )
  Begin {
    $connectResults = Connect-Account
  }
  Process {
    $resource = Get-AzAksNodePool -ResourceGroupName $ResourceGroupName -ClusterName $ClusterName -Name $Name

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
