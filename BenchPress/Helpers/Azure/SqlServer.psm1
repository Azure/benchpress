function Get-SqlServer([string]$serverName, [string]$resourceGroupName) {
  $resource = Get-AzSqlServer -ResourceGroupName $resourceGroupName -ServerName $serverName
  return $resource
}

function Get-SqlServerExists([string]$serverName, [string]$resourceGroupName) {
  $resource = Get-SqlServer $serverName $resourceGroupName
  return ($null -ne $resource)
}

Export-ModuleMember -Function `
  Get-SqlServer, Get-SqlServerExists
