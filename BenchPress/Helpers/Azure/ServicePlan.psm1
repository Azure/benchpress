function Get-AppServicePlan {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$appServicePlanName,

    [Parameter(Mandatory=$true)]
    [string]$resourceGroupName
  )

  $resource = Get-AzAppServicePlan -ResourceGroupName $resourceGroupName -Name $appServicePlanName
  return $resource
}

function Get-AppServicePlanExists {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$appServicePlanName,

    [Parameter(Mandatory=$true)]
    [string]$resourceGroupName
  )
  $resource = Get-AppServicePlan $appServicePlanName $resourceGroupName
  return ($null -ne $resource)
}

Export-ModuleMember -Function `
  Get-AppServicePlan, Get-AppServicePlanExists
