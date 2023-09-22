# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-OperationalInsightsWorkspace {
  <#
    .SYNOPSIS
      Confirms that an Operational Insights Workspace exists.

    .DESCRIPTION
      The Confirm-AzBPOperationalInsightsWorkspace cmdlet gets an Operational Insights Workspace using the specified
      Workspace and Resource Group names.

    .PARAMETER Name
      The name of the Operational Insights Workspace.

    .PARAMETER ResourceGroupName
      The name of the Resource Group. The name is case insensitive.

    .EXAMPLE
      Confirm-AzBPOperationalInsightsWorkspace -Name "benchpresstest" -ResourceGroupName "rgbenchpresstest"

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
    $resource = Get-AzOperationalInsightsWorkspace -ResourceGroupName $ResourceGroupName -Name $Name

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
