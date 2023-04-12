# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-SynapseWorkspace {
  <#
    .SYNOPSIS
      Confirms that a Synapse Workspace exists.

    .DESCRIPTION
      The Confirm-AzBPSynapseWorkspace cmdlet gets a Synapse Workspace using the specified Synapse Workspace and
      Resource Group names.

    .PARAMETER WorkspaceName
      The name of the Synapse Workspace.

    .PARAMETER ResourceGroupName
      The name of the Resource Group. The name is case insensitive.

    .EXAMPLE
      Confirm-AzBPSynapseWorkspace -WorkspaceName "benchpresstest" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$WorkspaceName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Begin {
    $connectResults = Connect-Account
  }
  Process {
    $resource = Get-AzSynapseWorkspace -ResourceGroupName $ResourceGroupName -Name $WorkspaceName

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
