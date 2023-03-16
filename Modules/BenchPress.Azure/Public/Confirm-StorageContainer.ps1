# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-StorageContainer {
  <#
    .SYNOPSIS
      Confirms that a Storage Container exists.

    .DESCRIPTION
      The Confirm-AzBPStorageContainer cmdlet gets a Storage Container using the specified Storage Account, Container
      and Resource Group name.

    .PARAMETER Name
      The name of the Storage Container

    .PARAMETER AccountName
      The name of the Storage Account

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPStorageContainer -Name "teststgcontainer" -AccountName "teststgacct" -ResourceGroupName "testrg"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$Name,

    [Parameter(Mandatory=$true)]
    [string]$AccountName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Begin {
    $ConnectResults = Connect-Account
  }
  Process {
      $Resource = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -AccountName $AccountName `
       | Get-AzStorageContainer -Name $Name

      [ConfirmResult]::new($Resource, $ConnectResults.AuthenticationData)
  }
  End { }
}
