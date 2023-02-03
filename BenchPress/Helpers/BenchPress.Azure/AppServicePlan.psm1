<#
.SYNOPSIS
  Gets an App Service Plan.

.DESCRIPTION
  The Get-AzBPAppServicePlan cmdlet gets an App Service Plan using the specified App Service Plan and
  Resource Group name.

.PARAMETER AppServicePlanName
  The name of the App Service Plan

.PARAMETER ResourceGroupName
  The name of the Resource Group

.EXAMPLE
  Get-AzBPAppServicePlan -AppServicePlanName "benchpresstest" -ResourceGroupName "rgbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  Microsoft.Azure.Commands.WebApps.Models.WebApp.PSAppServicePlan
#>
function Get-AppServicePlan {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$AppServicePlanName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )

  $resource = Get-AzAppServicePlan -ResourceGroupName $ResourceGroupName -Name $AppServicePlanName
  return $resource
}

<#
.SYNOPSIS
  Gets if an App Service Plan exists.

.DESCRIPTION
  The Get-AzBPAppServicePlanExist cmdlet checks if an App Service Plan exists using the specified
  App Service Plan and Resource Group name.

.PARAMETER AppServicePlanName
  The name of the App Service Plan

.PARAMETER ResourceGroupName
  The name of the Resource Group

.EXAMPLE
  Get-AzBPAppServicePlanExist -AppServicePlanName "benchpresstest" -ResourceGroupName "rgbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  System.Boolean
#>
function Get-AppServicePlanExist {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$AppServicePlanName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )

  $resource = Get-AppServicePlan -AppServicePlanName $AppServicePlanName -ResourceGroupName $ResourceGroupName
  return ($null -ne $resource)
}

Export-ModuleMember -Function Get-AppServicePlan, Get-AppServicePlanExist


