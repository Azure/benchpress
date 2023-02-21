using module ./public/classes/ConfirmResult.psm1

Import-Module $PSScriptRoot/Authentication.psm1

<#
.SYNOPSIS
  Confirms that an App Service Plan exists.

.DESCRIPTION
  The Confirm-AzBPAppServicePlan cmdlet gets an App Service Plan using the specified App Service Plan and
  Resource Group name.

.PARAMETER AppServicePlanName
  The name of the App Service Plan

.PARAMETER ResourceGroupName
  The name of the Resource Group

.EXAMPLE
  Confirm-AzBPAppServicePlan -AppServicePlanName "benchpresstest" -ResourceGroupName "rgbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  ConfirmResult
#>
function Confirm-AppServicePlan {
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$AppServicePlanName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Begin {
    $ConnectResults = Connect-Account
  }
  Process {
    [ConfirmResult]$Results = $null

    try {
      $Resource = Get-AzAppServicePlan -ResourceGroupName $ResourceGroupName -Name $AppServicePlanName

      $Results = [ConfirmResult]::new($Resource, $ConnectResults.AuthenticationData)
    } catch {
      $ErrorRecord = $_
      $Results = [ConfirmResult]::new($ErrorRecord, $ConnectResults.AuthenticationData)
    }

    $Results
  }
  End { }
}

Export-ModuleMember -Function Confirm-AppServicePlan
