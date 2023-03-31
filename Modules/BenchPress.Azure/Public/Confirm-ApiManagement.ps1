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
      Specifies the name of the resource group under in which this cmdlet gets the API Management service.

    .PARAMETER Name
      Specifies the name of API Management service.

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
    $ConnectResults = Connect-Account
  }
  Process {
    $Resource = Get-AzApiManagement -ResourceGroupName $ResourceGroupName -Name $Name

    [ConfirmResult]::new($Resource, $ConnectResults.AuthenticationData)
  }
  End { }
}
