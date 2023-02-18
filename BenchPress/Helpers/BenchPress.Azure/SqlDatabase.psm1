using module ./public/classes/ConfirmResult.psm1

Import-Module $PSScriptRoot/Authentication.psm1

<#
.SYNOPSIS
  Confirms that one or more SQL Databases exist.

.DESCRIPTION
  The Confirm-AzBPSqlDatabase cmdlet gets one or more SQL Databases using the specified SQL Database, SQL Server and
  Resource Group name.

.PARAMETER DatabaseName
  The name of the SQL Database

.PARAMETER DatabaseServer
  The name of the SQL Server

.PARAMETER ResourceGroupName
  The name of the Resource Group

.EXAMPLE
  Confirm-AzBPSqlDatabase -ServerName "testserver" -ResourceGroupName "rgbenchpresstest"

.EXAMPLE
  Confirm-AzBPSqlDatabase -DatabaseName "testdb" -ServerName "testserver" -ResourceGroupName "rgbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  ConfirmResult
#>
function Confirm-SqlDatabase {
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$false)]
    [string]$DatabaseName,

    [Parameter(Mandatory=$true)]
    [string]$ServerName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Begin {
    $ConnectResults = Connect-Account
  }
  Process {
    [ConfirmResult]$Results = $null

    try {
      [Microsoft.Azure.Commands.Sql.Database.Model.AzureSqlDatabaseModel]$Resource = $null

      if ([string]::IsNullOrEmpty($databaseName)) {
        $Resource = Get-AzSqlDatabase -ResourceGroupName $resourceGroupName -ServerName $serverName
      } else {
        $Resource = Get-AzSqlDatabase -ResourceGroupName $resourceGroupName -ServerName $serverName -DatabaseName $databaseName
      }

      $Results = [ConfirmResult]::new($Resource, $ConnectResults.AuthenticationData)
    } catch {
      $Exception = $_
      $ErrorRecord = [System.Management.Automation.ErrorRecord]::new(
        $Exception,
        "GetResourceError",
        [System.Management.Automation.ErrorCategory]::InvalidResult,
        $null
      )

      $Results = [ConfirmResult]::new($ErrorRecord, $ConnectResults.AuthenticationData)
    }

    $Results
  }
  End { }
}

Export-ModuleMember -Function Confirm-SqlDatabase
