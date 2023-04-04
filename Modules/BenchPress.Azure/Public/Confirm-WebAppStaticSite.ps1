# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-WebAppStaticSite {
  <#
    .SYNOPSIS
      Confirms that a Web App Static Site exists.

    .DESCRIPTION
      The Confirm-AzBPWebAppStaticSite cmdlet gets a Web App Static Site using the specified Web App and
      Resource Group name.

    .PARAMETER StaticWebAppName
      The name of the Web App Static Site

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPWebAppStaticSite -StaticWebAppName "benchpresstest" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$StaticWebAppName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Begin {
    $connectResults = Connect-Account
  }
  Process {
      $resource = Get-AzStaticWebApp -ResourceGroupName $ResourceGroupName -Name $StaticWebAppName

      [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
