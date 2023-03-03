# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-WebApp {
  <#
    .SYNOPSIS
      Confirms that a Web App exists.

    .DESCRIPTION
      The Confirm-AzBPWebApp cmdlet gets a Web App using the specified Web App and
      Resource Group name.

    .PARAMETER WebAppName
      The name of the Web App

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPWebApp -WebAppName "benchpresstest" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$WebAppName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Begin {
    $ConnectResults = Connect-Account
  }
  Process {
      $Resource = Get-AzWebApp -ResourceGroupName $ResourceGroupName -Name $WebAppName

      [ConfirmResult]::new($Resource, $ConnectResults.AuthenticationData)
  }
  End { }
}
