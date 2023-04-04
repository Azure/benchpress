# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-ApiManagement {
  <#
    .SYNOPSIS
      Confirms that an API Management Service exists.

    .DESCRIPTION
      The Confirm-AzBPApiManagement cmdlet gets an API Management Service using the specified API Management Service
      and Resource Group names.

    .PARAMETER ResourceGroupName
      The name of the Resource Group. The name is case insensitive.

    .PARAMETER Name
      The name of the API Management Service.

    .EXAMPLE
      Confirm-AzBPApiManagement -ResourceGroupName "rgbenchpresstest" -Name "benchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory=$true)]
    [string]$Name
  )
  Begin {
    $connectResults = Connect-Account
  }
  Process {
    $resource = Get-AzApiManagement -ResourceGroupName $ResourceGroupName -Name $Name

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
