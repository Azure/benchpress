# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-AksCluster {
  <#
    .SYNOPSIS
      Confirms that an AKS Cluster exists.

    .DESCRIPTION
      The Confirm-AzBPAksCluster cmdlet gets an AKS cluster using the specified AKS Cluster and Resource Group name.

    .PARAMETER AKSName
      The name of the AKS Cluster

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPAksCluster -AKSName "benchpresstest" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$AksName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Begin {
    $connectResults = Connect-Account
  }
  Process {
    $resource = Get-AzAksCluster -ResourceGroupName $ResourceGroupName -Name $AksName

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
