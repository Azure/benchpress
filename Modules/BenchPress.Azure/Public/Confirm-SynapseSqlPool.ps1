﻿# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-SynapseSqlPool {
  <#
    .SYNOPSIS
      Confirms that a Synapse SQL Pool exists.

    .DESCRIPTION
      The Confirm-AzBPSynapseSqlPool cmdlet gets a SQL Pool under a Synapse Workspace using the specified
      Synapse Workspace, SQL Pool, and Resource Group names.

    .PARAMETER SynapseSqlPoolName
      The name of the SQL Pool.

    .PARAMETER WorkspaceName
      The name of the Synapse Workspace.

    .PARAMETER ResourceGroupName
      The name of the Resource Group. The name is case insensitive.

    .EXAMPLE
      Confirm-AzBPSynapseSqlPool -SynapseSqlPoolName "benchpresstest" -WorkspaceName "wstest" `
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
    [string]$SynapseSqlPoolName,

    [Parameter(Mandatory=$true)]
    [string]$WorkspaceName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Begin {
    $connectResults = Connect-Account
  }
  Process {
    $resource = Get-AzSynapseSqlPool -ResourceGroupName $ResourceGroupName -WorkspaceName $WorkspaceName -Name $SynapseSqlPoolName

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
