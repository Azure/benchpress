# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-StreamAnalyticsFunction {
  <#
    .SYNOPSIS
      Confirms that a Stream Analytics Function exists.

    .DESCRIPTION
      The Confirm-AzBPStreamAnalyticsFunction cmdlet gets a Stream Analytics Function using the specified Resource
      Group, the Job executing the Function, and the Function names.

    .PARAMETER ResourceGroupName
      The name of the Resource Group. The name is case insensitive.

    .PARAMETER JobName
      The name of the Streaming Job.

    .PARAMETER Name
      The name of the Function.

    .EXAMPLE
      Confirm-AzBPStreamAnalyticsFunction -ResourceGroupName "rgbenchpresstest" -JobName "jn" -Name "benchpresstest"

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
    [string]$JobName,

    [Parameter(Mandatory=$true)]
    [string]$Name
  )
  Begin {
    $connectResults = Connect-Account
  }
  Process {
    $resource = Get-AzStreamAnalyticsFunction -ResourceGroupName $ResourceGroupName -JobName $JobName -Name $Name

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
