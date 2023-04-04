# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-AppServicePlan {
  <#
    .SYNOPSIS
      Confirms that an App Service Plan exists.

    .DESCRIPTION
      The Confirm-AzBPAppServicePlan cmdlet gets an App Service Plan using the specified App Service Plan and
      Resource Group names.

    .PARAMETER AppServicePlanName
      The name of the App Service Plan.

    .PARAMETER ResourceGroupName
      The name of the Resource Group. The name is case insensitive.

    .EXAMPLE
      Confirm-AzBPAppServicePlan -AppServicePlanName "benchpresstest" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$AppServicePlanName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Begin {
    $connectResults = Connect-Account
  }
  Process {
    $resource = Get-AzAppServicePlan -ResourceGroupName $ResourceGroupName -Name $AppServicePlanName

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
