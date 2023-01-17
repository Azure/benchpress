function Get-SqlDatabase {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$false)]
    [string]$DatabaseName,

    [Parameter(Mandatory=$true)]
    [string]$ServerName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )

  if ([string]::IsNullOrEmpty($databaseName)) {
    $resource = Get-AzSqlDatabase -ResourceGroupName $resourceGroupName -ServerName $serverName
  } else {
    $resource = Get-AzSqlDatabase -ResourceGroupName $resourceGroupName -ServerName $serverName -DatabaseName $databaseName
  }

  return $resource
}

function Get-SqlDatabaseExist {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$false)]
    [string]$DatabaseName,

    [Parameter(Mandatory=$true)]
    [string]$ServerName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )

  $resource = Get-SqlDatabase -DatabaseName $DatabaseName -ServerName $ServerName -ResourceGroupName $ResourceGroupName
  return ($null -ne $resource)
}

Export-ModuleMember -Function Get-SqlDatabase, Get-SqlDatabaseExist
