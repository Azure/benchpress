# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-StorageAccount {
  <#
    .SYNOPSIS
      Confirms that a Storage Account exists.

    .DESCRIPTION
      The Confirm-AzBPStorageAccount cmdlet gets a Storage Account using the specified Storage Account and
      Resource Group name.

    .PARAMETER Name
      The name of the Storage Account

    .PARAMETER ResourceGroupName
      The name of the Resource Group

    .EXAMPLE
      Confirm-AzBPStorageAccount -Name "teststorageaccount" -ResourceGroupName "rgbenchpresstest"

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
    [string]$ResourceGroupName
  )
  Begin {
    $connectResults = Connect-Account
  }
  Process {
      $resource = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $Name

      [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
