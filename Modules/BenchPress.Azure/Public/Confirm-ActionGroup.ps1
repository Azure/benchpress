# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-ActionGroup {
  <#
    .SYNOPSIS
      Confirms that an Action Group exists.

    .DESCRIPTION
      The Confirm-AzBPActionGroup cmdlet gets an action group using the specified Action Group and Resource Group name.

    .PARAMETER ActionGroupName
      The name of the Azure Action Group

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPActionGroup -ActionGroupName "benchpresstest" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ActionGroupName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Begin {
    $connectResults = Connect-Account
  }
  Process {
    $resource = Get-AzActionGroup -ResourceGroupName $ResourceGroupName -Name $ActionGroupName

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
