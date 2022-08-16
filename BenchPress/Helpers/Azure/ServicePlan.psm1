function Get-AppServicePlan {
  param (
    [string]$appServicePlanName,
    [string]$resourceGroupName
  )
  $resource = Get-AzAppServicePlan -ResourceGroupName $resourceGroupName -Name $appServicePlanName
  return $resource
}

function Get-AppServicePlanExists {
  param (
    [string]$appServicePlanName,
    [string]$resourceGroupName
  )
  $resource = Get-AppServicePlan $appServicePlanName $resourceGroupName
  return ($null -ne $resource)
}

Export-ModuleMember -Function `
  Get-AppServicePlan, Get-AppServicePlanExists
