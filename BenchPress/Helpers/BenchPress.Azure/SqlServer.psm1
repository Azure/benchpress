<#
.SYNOPSIS
  Gets a SQL Server.

.DESCRIPTION
  The Get-AzBPSqlServer cmdlet gets a SQL Server using the specified SQL Server and
  Resource Group name.

.PARAMETER ServerName
  The name of the SQL Server

.PARAMETER ResourceGroupName
  The name of the Resource Group

.EXAMPLE
  Get-AzBPSqlServer -ServerName "testserver" -ResourceGroupName "rgbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  Microsoft.Azure.Commands.Sql.Server.Model.AzureSqlServerModel
#>
function Get-SqlServer {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ServerName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )

  $resource = Get-AzSqlServer -ResourceGroupName $ResourceGroupName -ServerName $ServerName
  return $resource
}

<#
.SYNOPSIS
  Gets if a SQL Server exists.

.DESCRIPTION
  The Get-AzBPSqlServerExist cmdlet checks if a SQL Server exists using the specified
  SQL Server and Resource Group name.

.PARAMETER ServerName
  The name of the SQL Server

.PARAMETER ResourceGroupName
  The name of the Resource Group

.EXAMPLE
  Get-AzBPSqlServerExist -ServerName "benchpresstest" -ResourceGroupName "rgbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  System.Boolean
#>
function Get-SqlServerExist {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ServerName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )

  $resource = Get-SqlServer -ServerName $ServerName -ResourceGroupName $ResourceGroupName
  return ($null -ne $resource)
}

Export-ModuleMember -Function Get-SqlServer, Get-SqlServerExist

