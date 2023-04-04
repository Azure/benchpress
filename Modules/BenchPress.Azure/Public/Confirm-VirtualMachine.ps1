# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/../Private/Connect-Account.ps1
# end INLINE_SKIP

function Confirm-VirtualMachine {
  <#
    .SYNOPSIS
      Confirms that a Virtual Machine exists.

    .DESCRIPTION
      The Confirm-AzBPVirtualMachine cmdlet gets a Virtual Machine using the specified Virtual Machine and
      Resource Group names.

    .PARAMETER VirtualMachineName
      The name of the Virtual Machine.

    .PARAMETER ResourceGroupName
      The name of the Resource Group. The name is case insensitive.

    .EXAMPLE
      Confirm-AzBPVirtualMachine -VirtualMachineName "benchpresstest" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory=$true)]
    [string]$VirtualMachineName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  Begin {
    $connectResults = Connect-Account
  }
  Process {
      $resource = Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VirtualMachineName

      [ConfirmResult]::new($resource, $connectResults.AuthenticationData)
  }
  End { }
}
