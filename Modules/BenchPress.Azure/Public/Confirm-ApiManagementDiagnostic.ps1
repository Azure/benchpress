# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-ApiManagementDiagnostic {
  <#
    .SYNOPSIS
      Confirms that an API Management Diagnostic exists.

    .DESCRIPTION
      The Confirm-AzBPApiManagementDiagnostic cmdlet gets an API Management Diagnostic using the specified API
      Diagnostic, API, API Management Service, and Resource Group names.

    .PARAMETER ResourceGroupName
      Specifies the name of the resource group under which an API Management service is deployed.

    .PARAMETER ServiceName
      Specifies the name of the deployed API Management service.

    .PARAMETER ApiId
      Identifier of existing API. If specified will return API-scope diagnostic. This parameters is required.

    .PARAMETER Name
      Identifier of existing diagnostic. This will return product-scope policy. This parameters is required.

    .EXAMPLE
      Confirm-AzBPApiManagementDiagnostic -ResourceGroupName "rgbenchpresstest" -ServiceName "servicetest" `
        -ApiId "apiidtest" -Name "benchpresstest"

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
    $Resource = New-AzApiManagementContext -ResourceGroupName $ResourceGroupName -ServiceName $ServiceName
      | Get-AzApiManagementDiagnostic -DiagnosticId $Name

    [ConfirmResult]::new($Resource, $ConnectResults.AuthenticationData)
  }
  End { }
}
