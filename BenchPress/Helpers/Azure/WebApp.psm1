function Get-WebApp([string]$webAppName, [string]$resourceGroupName) {
  $resource = Get-AzWebApp -ResourceGroupName $resourceGroupName -Name $webAppName
  return $resource
}

function Get-WebAppExists([string]$webAppName, [string]$resourceGroupName) {
  $resource = Get-WebApp $webAppName $resourceGroupName
  return ($null -ne $resource)
}

Export-ModuleMember -Function `
  Get-WebApp, Get-WebAppExists
