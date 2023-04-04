# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-ApiManagementApi {
  <#
    .SYNOPSIS
      Confirms that an API Management API exists.

    .DESCRIPTION
      The Confirm-AzBPApiManagementApi cmdlet gets an API Management API using the specified API, API Management
      Service, and Resource Group names.

    .PARAMETER ResourceGroupName
      The name of the Resource Group. The name is case insensitive.

    .PARAMETER ServiceName
      The name of the API Management Service.

    .PARAMETER Name
      The name of the API.

    .EXAMPLE
      Confirm-AzBPApiManagementApi -ResourceGroupName "rgbenchpresstest" -ServiceName "servicetest" -Name "benchpresstest"

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
    $resource = New-AzApiManagementContext -ResourceGroupName $ResourceGroupName -ServiceName $ServiceName
      | Get-AzApiManagementApi -Name $Name

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
