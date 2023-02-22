Import-Module $PSScriptRoot/Authentication.psm1

<#
.SYNOPSIS
  Gets a Virtual Machine.

.DESCRIPTION
  The Get-AzBPVirtualMachine cmdlet gets a Virtual Machine using the specified Virtual Machine and
  Resource Group name.

.PARAMETER VirtualMachineName
  The name of the Virtual Machine

.PARAMETER ResourceGroupName
  The name of the Resource Group

.EXAMPLE
  Get-AzBPVirtualMachine -VirtualMachineName "benchpresstest" -ResourceGroupName "rgbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  Microsoft.Azure.Commands.Compute.Models.PSVirtualMachine
#>
function Get-VirtualMachine {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$VirtualMachineName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )

  Connect-Account

  $resource = Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VirtualMachineName
  return $resource
}

<#
.SYNOPSIS
  Gets if a Virtual Machine exists.

.DESCRIPTION
  The Get-AzBPVirtualMachineExist cmdlet checks if a Virtual Machine exists using the specified
  Virtual Machine and Resource Group name.

.PARAMETER VirtualMachineName
  The name of the Virtual Machine

.PARAMETER ResourceGroupName
  The name of the Resource Group

.EXAMPLE
  Get-AzBPVirtualMachineExist -VirtualMachineName "benchpresstest" -ResourceGroupName "rgbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  System.Boolean
#>
function Get-VirtualMachineExist {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$VirtualMachineName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )

  $resource = Get-VirtualMachine -VirtualMachineName $VirtualMachineName -ResourceGroupName $ResourceGroupName
  return ($null -ne $resource)
}

Export-ModuleMember -Function Get-VirtualMachine, Get-VirtualMachineExist
