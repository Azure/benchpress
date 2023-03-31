# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-EventHub {
  <#
    .SYNOPSIS
      Confirms that an EventHub exists.

    .DESCRIPTION
      The Confirm-AzBPEventHub cmdlet gets an EventHub using the specified EventHub name, EventHub Namespace,
      and Resource Group name.

    .PARAMETER Name
      The name of the EventHub

    .PARAMETER NamespaceName
      The name of the EventHub Namespace

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPEventHub -Name "bpeventhub" -NamespaceName 'bpeventhubnamespace' -ResourceGroupName "rgbenchpresstest"

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
    [string]$NamespaceName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Begin {
    $connectResults = Connect-Account
  }
  Process {
    $resource = Get-AzEventHub -ResourceGroupName $ResourceGroupName -NamespaceName $NamespaceName -Name $Name

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
