# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-EventHubNamespace {
  <#
    .SYNOPSIS
      Confirms that an EventHub Namespace exists.

    .DESCRIPTION
      The Confirm-AzBPEventHubNamespace cmdlet gets an EventHub Namespace using the specified EventHub Namespace name,
      and Resource Group name.

    .PARAMETER NamespaceName
      The name of the EventHub Namespace

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPEventHubNamespace -NamespaceName 'bpeventhubnamespace' -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$NamespaceName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Begin {
    $ConnectResults = Connect-Account
  }
  Process {
    $Resource = Get-AzEventHubNamespace -ResourceGroupName $ResourceGroupName -NamespaceName $NamespaceName

    [ConfirmResult]::new($Resource, $ConnectResults.AuthenticationData)
  }
  End { }
}
