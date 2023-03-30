# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-ApiManagementPolicy {
  <#
    .SYNOPSIS
      Confirms that an API Management Policy exists.

    .DESCRIPTION
      The Confirm-AzBPApiManagementPolicy cmdlet gets an API Management Policy using the specified API, API Management
      Service, and Resource Group names.

    .PARAMETER ResourceGroupName
      Specifies the name of the resource group under which an API Management service is deployed.

    .PARAMETER ServiceName
      Specifies the name of the deployed API Management service.

    .PARAMETER ApiId
      Specifies the identifier of the existing API. This cmdlet returns the API-scope policy.

    .EXAMPLE
      Confirm-AzBPApiManagementPolicy -ResourceGroupName "rgbenchpresstest" -ServiceName "servicetest" `
        -ApiId "benchpresstest"

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
    [string]$ApiId
  )
  Begin {
    $ConnectResults = Connect-Account
  }
  Process {
    $policy = New-AzApiManagementContext -ResourceGroupName $ResourceGroupName -ServiceName $ServiceName
      | Get-AzApiManagementPolicy -ApiId $ApiId

    # Get-AzApiManagementPolicy returns the XML for a policy, not a resource
    if ([string]::IsNullOrWhiteSpace($policy)) {
      $policy = $null
    }

    [ConfirmResult]::new($policy, $ConnectResults.AuthenticationData)
  }
  End { }
}
