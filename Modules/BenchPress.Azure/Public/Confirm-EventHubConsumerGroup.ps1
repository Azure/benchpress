# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-EventHubConsumerGroup {
  <#
    .SYNOPSIS
      Confirms that an EventHub ConsumerGroup exists.

    .DESCRIPTION
      The Confirm-AzBPEventHubConsumerGroup cmdlet gets an Event Hub Consumer Group using the specified Event Hub
      Consumer Group, Event Hub Namespace, Event Hub, and Resource Group names.

    .PARAMETER Name
      The name of the Event Hub Consumer Group.

    .PARAMETER NamespaceName
      The name of the Event Hub Namespace.

    .PARAMETER EventHubName
      The name of the Event Hub.

    .PARAMETER ResourceGroupName
      The name of the Resource Group. The name is case insensitive.

    .EXAMPLE
      Confirm-AzBPEventHubConsumerGroup -Name 'consumergrouptest' -NamespaceName 'bpeventhubnamespace' -EventHubName 'bpeventhub' -ResourceGroupName "rgbenchpresstest"

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
    [string]$EventHubName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Begin {
    $connectResults = Connect-Account
  }
  Process {
    $params = @{
      Name              = $Name
      NamespaceName     = $NamespaceName
      EventHubName      = $EventHubName
      ResourceGroupName = $ResourceGroupName
    }

    $resource = Get-AzEventHubConsumerGroup @params

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
