using module ./public/classes/ConfirmResult.psm1

Import-Module $PSScriptRoot/Authentication.psm1

<#
.SYNOPSIS
  Confirms that a Virtual Machine exists.

.DESCRIPTION
  The Confirm-AzBPVirtualMachine cmdlet gets a Virtual Machine using the specified Virtual Machine and
  Resource Group name.

.PARAMETER VirtualMachineName
  The name of the Virtual Machine

.PARAMETER ResourceGroupName
  The name of the Resource Group

.EXAMPLE
  Confirm-AzBPVirtualMachine -VirtualMachineName "benchpresstest" -ResourceGroupName "rgbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  ConfirmResult
#>
function Confirm-VirtualMachine {
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$VirtualMachineName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Begin {
    $ConnectResults = Connect-Account
  }
  Process {
    [ConfirmResult]$Results = $null

    try {
      $Resource = Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VirtualMachineName

      $Results = [ConfirmResult]::new($Resource, $ConnectResults.AuthenticationData)
    } catch {
      $ErrorRecord = $_
      $Results = [ConfirmResult]::new($ErrorRecord, $ConnectResults.AuthenticationData)
    }

    $Results
  }
}

Export-ModuleMember -Function Confirm-VirtualMachine
