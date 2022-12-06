function Get-SqlServer {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$serverName,

    [Parameter(Mandatory=$true)]
    [string]$resourceGroupName
  )

  $resource = Get-AzSqlServer -ResourceGroupName $resourceGroupName -ServerName $serverName
  return $resource
}

function Get-SqlServerExists {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$serverName,

    [Parameter(Mandatory=$true)]
    [string]$resourceGroupName
  )

  $resource = Get-SqlServer $serverName $resourceGroupName
  return ($null -ne $resource)
}

Export-ModuleMember -Function `
  Get-SqlServer, Get-SqlServerExists
