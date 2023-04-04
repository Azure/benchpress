# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-EventHubNamespace {
  <#
    .SYNOPSIS
      Confirms that an Event Hub Namespace exists.

    .DESCRIPTION
      The Confirm-AzBPEventHubNamespace cmdlet gets an Event Hub Namespace using the specified Event Hub Namespace
      and Resource Group names.

    .PARAMETER NamespaceName
      The name of the Event Hub Namespace.

    .PARAMETER ResourceGroupName
      The name of the Resource Group. The name is case insensitive.

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
    $connectResults = Connect-Account
  }
  Process {
    $resource = Get-AzEventHubNamespace -ResourceGroupName $ResourceGroupName -NamespaceName $NamespaceName

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
