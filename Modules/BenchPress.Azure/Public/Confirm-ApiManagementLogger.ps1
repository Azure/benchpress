# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-ApiManagementLogger {
  <#
    .SYNOPSIS
      Confirms that an API Management Logger exists.

    .DESCRIPTION
      The Confirm-AzBPApiManagementLogger cmdlet gets an API Management Logger using the specified Logger, API
      Management Service, and Resource Group names.

    .PARAMETER ResourceGroupName
      Specifies the name of the resource group under which an API Management service is deployed.

    .PARAMETER ServiceName
      Specifies the name of the deployed API Management service.

    .PARAMETER Name
      Specifies the ID of the specific logger to get.

    .EXAMPLE
      Confirm-AzBPApiManagementLogger -ResourceGroupName "rgbenchpresstest" -ServiceName "servicetest" `
        -Name "benchpresstest"

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
    [string]$ServiceName,

    [Parameter(Mandatory=$true)]
    [string]$Name
  )
  Begin {
    $ConnectResults = Connect-Account
  }
  Process {
    $Context = New-AzApiManagementContext -ResourceGroupName $ResourceGroupName -ServiceName $ServiceName
    $Resource = Get-AzApiManagementLogger -Context $Context -LoggerId $Name

    [ConfirmResult]::new($Resource, $ConnectResults.AuthenticationData)
  }
  End { }
}
