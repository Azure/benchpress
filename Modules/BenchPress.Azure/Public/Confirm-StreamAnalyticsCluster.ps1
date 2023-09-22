# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-StreamAnalyticsCluster {
  <#
    .SYNOPSIS
      Confirms that a Stream Analytics cluster exists.

    .DESCRIPTION
      The Confirm-AzBPStreamAnalyticsCluster cmdlet gets a Stream Analytics Cluster using the specified Cluster and
      Resource Group names.

    .PARAMETER Name
      The name of the Stream Analytics Cluster.

    .PARAMETER ResourceGroupName
      The name of the Resource Group. The name is case insensitive.

    .EXAMPLE
      Confirm-AzBPStreamAnalyticsCluster -Name "benchpresstest" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$Name,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Begin {
    $connectResults = Connect-Account
  }
  Process {
    $resource = Get-AzStreamAnalyticsCluster -ResourceGroupName $ResourceGroupName -Name $Name

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
