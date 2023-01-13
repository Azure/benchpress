function Get-SqlDatabase {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$false)]
    [string]$databaseName,

    [Parameter(Mandatory=$true)]
    [string]$serverName,

    [Parameter(Mandatory=$true)]
    [string]$resourceGroupName
  )

  if ([string]::IsNullOrEmpty($databaseName)) {
    $resource = Get-AzSqlDatabase -ResourceGroupName $resourceGroupName -ServerName $serverName
  } else {
    $resource = Get-AzSqlDatabase -ResourceGroupName $resourceGroupName -ServerName $serverName -DatabaseName $databaseName
  }

  return $resource
}

function Get-SqlDatabaseExists {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$false)]
    [string]$databaseName,

    [Parameter(Mandatory=$true)]
    [string]$serverName,

    [Parameter(Mandatory=$true)]
    [string]$resourceGroupName
  )
  $resource = Get-SqlDatabase $databaseName $serverName $resourceGroupName
  return ($null -ne $resource)
}

Export-ModuleMember -Function `
  Get-SqlDatabase, Get-SqlDatabaseExists
