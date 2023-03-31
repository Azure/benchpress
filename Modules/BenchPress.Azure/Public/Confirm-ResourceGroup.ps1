# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-ResourceGroup {
  <#
    .SYNOPSIS
      Confirms that a Resource Group exists.

    .DESCRIPTION
      The Confirm-AzBPResourceGroup cmdlet gets a Resource Group using the specified Resource Group and
      Resource Group name.

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPResourceGroup -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Begin {
    $connectResults = Connect-Account
  }
  Process {
    $resource = Get-AzResourceGroup $ResourceGroupName

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
