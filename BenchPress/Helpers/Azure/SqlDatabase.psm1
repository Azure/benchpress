<#
.SYNOPSIS
  Gets one or more SQL Databases.

.DESCRIPTION
  The Get-AzBPSqlDatabase cmdlet gets one or more SQL Databases using the specified SQL Database, SQL Server and
  Resource Group name.

.PARAMETER DatabaseName
  The name of the SQL Database

.PARAMETER DatabaseServer
  The name of the SQL Server

.PARAMETER ResourceGroupName
  The name of the Resource Group

.EXAMPLE
  Get-AzBPSqlDatabase -ServerName "testserver" -ResourceGroupName "rgbenchpresstest"

.EXAMPLE
  Get-AzBPSqlDatabase -DatabaseName "testdb" -ServerName "testserver" -ResourceGroupName "rgbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  Microsoft.Azure.Commands.Sql.Database.Model.AzureSqlDatabaseModel[]
#>
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

<#
.SYNOPSIS
  Gets if a specific (or more than one) SQL Database exists.

.DESCRIPTION
  The Get-AzBPSqlDatabaseExist cmdlet checks if a specific (or more than one) SQL Database exists using the specified
  SQL Database, SQL Server and Resource Group name.

.PARAMETER DatabaseName
  The name of the SQL Database

.PARAMETER DatabaseServer
  The name of the SQL Server

.PARAMETER ResourceGroupName
  The name of the Resource Group

.EXAMPLE
  Get-AzBPSqlDatabaseExist -ServerName "testserver" -ResourceGroupName "rgbenchpresstest"

.EXAMPLE
  Get-AzBPSqlDatabaseExist -DatabaseName "testdb" -ServerName "testserver" -ResourceGroupName "rgbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  System.Boolean
#>
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
