# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-DiagnosticSetting{
  <#
    .SYNOPSIS
      Confirms that a Diagnostic Setting exists.

    .DESCRIPTION
      The Confirm-AzBPDiagnosticSetting cmdlet gets a Diagnostic Setting using the specified Diagnostic Setting name
      and the specified Resource Id.

    .PARAMETER Name
      The name of the Diagnostic Setting.

    .PARAMETER ResourceId
      The Id of the Resource.

    .EXAMPLE
      Confirm-AzBPDiagnosticSetting -Name "benchpresstest"
      -ResourceId "/subscriptions/{subscriptionId}/resourceGroups/{rg}/providers/Microsoft.ContainerService/managedClusters/aksnqpog"

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
    [string]$ResourceId
  )
  Begin {
    $connectResults = Connect-Account
  }
  Process {
    $resource = Get-AzDiagnosticSetting -ResourceId $ResourceId -Name $Name

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
