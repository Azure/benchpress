using module ./public/classes/ConfirmResult.psm1

Import-Module $PSScriptRoot/Authentication.psm1
<#
.SYNOPSIS
  Confirms that a SQL Server exists.

.DESCRIPTION
  The Confirm-AzBPSqlServer cmdlet gets a SQL Server using the specified SQL Server and
  Resource Group name.

.PARAMETER ServerName
  The name of the SQL Server

.PARAMETER ResourceGroupName
  The name of the Resource Group

.EXAMPLE
  Confirm-AzBPSqlServer -ServerName "testserver" -ResourceGroupName "rgbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  ConfirmResult
#>
function Confirm-SqlServer {
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
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
      $Resource = Get-AzSqlServer -ResourceGroupName $ResourceGroupName -ServerName $ServerName

      $Results = [ConfirmResult]::new($Resource, $ConnectResults.AuthenticationData)
    } catch {
      $ErrorRecord = $_
      $Results = [ConfirmResult]::new($ErrorRecord, $ConnectResults.AuthenticationData)
    }

    $Results
  }
}

Export-ModuleMember -Function Confirm-SqlServer
