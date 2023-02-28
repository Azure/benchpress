using module ./public/classes/ConfirmResult.psm1

Import-Module $PSScriptRoot/Authentication.psm1

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
  Confirm-AzBPStorageAccount -Name "testaccount" -ResourceGroupName "rgbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  ConfirmResult
#>
function Confirm-StorageAccount {
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$Name,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Begin {
    $ConnectResults = Connect-Account
  }
  Process {
    [ConfirmResult]$Results = $null

    try {
      $Resource = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $Name

      $Results = [ConfirmResult]::new($Resource, $ConnectResults.AuthenticationData)
    } catch {
      $ErrorRecord = $_
      $Results = [ConfirmResult]::new($ErrorRecord, $ConnectResults.AuthenticationData)
    }

    $Results
  }
}

Export-ModuleMember -Function Confirm-StorageAccount
