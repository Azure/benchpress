function Get-SqlDatabase([string]$databaseName, [string]$serverName, [string]$resourceGroupName) {
  $resource = Get-AzSqlDatabase -ResourceGroupName $resourceGroupName -ServerName $serverName -DatabaseName $databaseName
  return $resource
}

function Get-SqlDatabaseExists([string]$databaseName, [string]$serverName, [string]$resourceGroupName) {
  $resource = Get-SqlDatabase $databaseName $serverName $resourceGroupName
  return ($null -ne $resource)
}

Export-ModuleMember -Function `
  Get-SqlDatabase, Get-SqlDatabaseExists
