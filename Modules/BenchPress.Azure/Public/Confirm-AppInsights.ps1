# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-AppInsights {
  <#
    .SYNOPSIS
      Confirms that an Application Insights exists.

    .DESCRIPTION
      The Confirm-AzBPAppInsights cmdlet gets an Application Insights using the specified Application Insights name
      and Resource Group name.

    .PARAMETER Name
      The name of the Application Insights

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPAppInsights -Name "benchpresstest" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$Name,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Begin {
    $ConnectResults = Connect-Account
  }
  Process {
    $Resource = Get-AzApplicationInsights -ResourceGroupName $ResourceGroupName -Name $Name

    [ConfirmResult]::new($Resource, $ConnectResults.AuthenticationData)
  }
  End { }
}
