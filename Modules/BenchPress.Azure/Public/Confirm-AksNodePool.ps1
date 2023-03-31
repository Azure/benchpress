# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-AksNodePool {
  <#
    .SYNOPSIS
      Confirms that an AKS Node Pool exists.

    .DESCRIPTION
      The Confirm-AzBPAksNodePool cmdlet gets an AKS Node Pool using the specified AKS Node Pool and Resource Group
      name.

    .PARAMETER AKSName
      The name of the AKS Node Pool

    .PARAMETER ResourceGroupName
      The name of the Resource Group

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
    $ConnectResults = Connect-Account
  }
  Process {
    $Resource = Get-AzAksNodePool -ResourceGroupName $ResourceGroupName -ClusterName $ClusterName -Name $Name

    [ConfirmResult]::new($Resource, $ConnectResults.AuthenticationData)
  }
  End { }
}
