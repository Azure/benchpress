﻿# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-SqlDatabase {
  <#
    .SYNOPSIS
      Confirms that a SQL Database exists.

    .DESCRIPTION
      The Confirm-AzBPSqlDatabase cmdlet gets a SQL Database using the specified SQL Database, SQL Server,
      and Resource Group names.

    .PARAMETER DatabaseName
      The name of the SQL Database.

    .PARAMETER DatabaseServer
      The name of the SQL Server.

    .PARAMETER ResourceGroupName
      The name of the Resource Group. The name is case insensitive.

    .EXAMPLE
      Confirm-AzBPSqlDatabase -ServerName "testserver" -ResourceGroupName "rgbenchpresstest"

    .EXAMPLE
      Confirm-AzBPSqlDatabase -DatabaseName "testdb" -ServerName "testserver" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$DatabaseName,

    [Parameter(Mandatory=$true)]
    [string]$ServerName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Begin {
    $connectResults = Connect-Account
  }
  Process {
    $requestParams = @{
      ResourceGroupName = $ResourceGroupName
      ServerName        = $ServerName
      DatabaseName      = $DatabaseName
    }

    $resource = Get-AzSqlDatabase @requestParams

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
