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
      Specifies the name of the resource group under which an API Management service is deployed.

    .PARAMETER ServiceName
      Specifies the name of the deployed API Management service.

    .PARAMETER Name
      Specifies the name of the API to get.

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
    $ConnectResults = Connect-Account
  }
  Process {
    $Resource = New-AzApiManagementContext -ResourceGroupName $ResourceGroupName -ServiceName $ServiceName
      | Get-AzApiManagementApi -Name $Name

    [ConfirmResult]::new($Resource, $ConnectResults.AuthenticationData)
  }
  End { }
}
