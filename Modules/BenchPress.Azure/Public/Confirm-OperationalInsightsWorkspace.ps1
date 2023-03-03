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
      Workspace Name and Resource Group name.

    .PARAMETER Name
      Specifies the workspace name.

    .PARAMETER ResourceGroupName
      Specifies the name of an Azure resource group.

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
    $ConnectResults = Connect-Account
  }
  Process {
    $Resource = Get-AzOperationalInsightsWorkspace -ResourceGroupName $ResourceGroupName -Name $Name

    [ConfirmResult]::new($Resource, $ConnectResults.AuthenticationData)
  }
  End { }
}
