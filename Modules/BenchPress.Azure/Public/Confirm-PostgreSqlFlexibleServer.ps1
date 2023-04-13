# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-PostgreSqlFlexibleServer {
  <#
    .SYNOPSIS
      Confirms that a PostgreSQL Flexible Server exists.

    .DESCRIPTION
      The Confirm-AzBPPostgreSqlFlexibleServer cmdlet gets a PostgreSQL Flexible Server using the specified PostgreSQL
      Server Name and the Resource Group name.

    .PARAMETER ResourceGroupName
      The name of the resource group. The name is case insensitive.

    .PARAMETER Name
      The name of the server.

    .EXAMPLE
      Confirm-AzBPPostgreSqlFlexibleServer -ResourceGroupName "rgbenchpresstest" -Name "benchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory=$true)]
    [string]$Name
  )
  Begin {
    $connectResults = Connect-Account
  }
  Process {
    $resource = Get-AzPostgreSqlFlexibleServer -ResourceGroupName $ResourceGroupName -Name $Name

    [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}

