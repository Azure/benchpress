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
      The name of the Resource Group. The name is case insensitive.

    .PARAMETER ServiceName
      The name of the API Management Service.

    .PARAMETER ApiId
      The ID of the API. This cmdlet returns the API-scope policy.

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
    $connectResults = Connect-Account
  }
  Process {
    $policy = New-AzApiManagementContext -ResourceGroupName $ResourceGroupName -ServiceName $ServiceName
      | Get-AzApiManagementPolicy -ApiId $ApiId

    # Get-AzApiManagementPolicy returns the XML for a policy, not a resource
    if ([string]::IsNullOrWhiteSpace($policy)) {
      $policy = $null
    }

    [ConfirmResult]::new($policy, $connectResults.AuthenticationData)
  }
  End { }
}
