# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-SynapseWorkspace {
  <#
    .SYNOPSIS
      Confirms that a Synapse Workspace exists.

    .DESCRIPTION
      The Confirm-AzBPSynapseWorkspace cmdlet gets a synapse workspace using the specified Synapse Workspace and
      Resource Group name.

    .PARAMETER SynapseWorkspaceName
      The name of the Synapse Workspace

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPSynapseWorkspace -SynapseWorkspaceName "benchpresstest" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$SynapseWorkspaceName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Begin {
    $ConnectResults = Connect-Account
  }
  Process {
    $Resource = Get-AzSynapseWorkspace -ResourceGroupName $ResourceGroupName -Name $SynapseWorkspaceName

    [ConfirmResult]::new($Resource, $ConnectResults.AuthenticationData)
  }
  End { }
}
