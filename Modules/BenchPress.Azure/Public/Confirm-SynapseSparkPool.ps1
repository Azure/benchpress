# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-SynapseSparkPool {
  <#
    .SYNOPSIS
      Confirms that a Synapse Spark pool exists.

    .DESCRIPTION
      The Confirm-AzBPSynapseSparkPool cmdlet gets a Spark pool under a Synapse workspace using the specified
      Synapse Workspace, Spark Pool and Resource Group name.

    .PARAMETER SynapseSparkPoolName
      The name of the Spark pool

    .PARAMETER WorkspaceName
      The name of the Synapse Workspace

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPSynapseSparkPool -SynapseSparkPoolName "benchpresstest" -WorkspaceName "wstest" `
        -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$SynapseSparkPoolName,

    [Parameter(Mandatory=$true)]
    [string]$WorkspaceName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Begin {
    $ConnectResults = Connect-Account
  }
  Process {
    $Resource = Get-AzSynapseSparkPool -ResourceGroupName $ResourceGroupName -WorkspaceName $WorkspaceName -Name $SynapseSparkPoolName

    [ConfirmResult]::new($Resource, $ConnectResults.AuthenticationData)
  }
  End { }
}
