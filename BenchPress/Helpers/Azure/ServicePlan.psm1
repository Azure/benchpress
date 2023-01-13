<#
.SYNOPSIS
  Helper function for App Service Plan

.DESCRIPTION
  Helper function for App Service Plan

.PARAMETER AppServicePlanName
  The name of the App Service Plan

.PARAMETER ResourceGroupName
  The name of the resource group

.EXAMPLE
  Get-AppServicePlan -AppServicePlanName "appsvcbenchpresstest" -ResourceGroupName "rgbenchpresstest"
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
  Helper function for App Service Plan

.DESCRIPTION
  Helper function for App Service Plan

.PARAMETER AppServicePlanName
  The name of the App Service Plan

.PARAMETER ResourceGroupName
  The name of the resource group

.EXAMPLE
  Get-AppServicePlan-AppServicePlanName "appsvcbenchpresstest" -ResourceGroupName "rgbenchpresstest"
#>
function Get-AppServicePlan{
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

Export-ModuleMember -Function Get-AppServicePlan, Get-AppServicePlanExists
