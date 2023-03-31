# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-StreamAnalyticsJob {
  <#
    .SYNOPSIS
      Confirms that a Stream Analytics Job exists.

    .DESCRIPTION
      The Confirm-AzBPStreamAnalyticsJob cmdlet gets a Stream Analytics Job using the specified Resource Group and
      Stream Analytics job name.

    .PARAMETER ResourceGroupName
      The name of the resource group. The name is case insensitive.

    .PARAMETER Name
      The name of the Stream Analytics job.

    .EXAMPLE
      Confirm-AzBPStreamAnalyticsCluster -ResourceGroupName "rgbenchpresstest" -Name "benchpresstest"

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
    $resource = Get-AzStreamAnalyticsJob -ResourceGroupName $ResourceGroupName -Name $Name

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
