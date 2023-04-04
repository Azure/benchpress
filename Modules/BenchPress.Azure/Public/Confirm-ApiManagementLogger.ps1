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
      The name of the Resource Group. The name is case insensitive.

    .PARAMETER ServiceName
      The name of the API Management Service.

    .PARAMETER Name
      The ID of the Logger.

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
    $connectResults = Connect-Account
  }
  Process {
    # Unlike the other Get-AzApiManagement* cmdlets Get-AzApiManagementLogger does not accept piping of the context
    $context = New-AzApiManagementContext -ResourceGroupName $ResourceGroupName -ServiceName $ServiceName
    $resource = Get-AzApiManagementLogger -Context $context -LoggerId $Name

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
