function Get-VirtualMachine {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$VirtualMachineName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )

  $resource = Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VirtualMachineName
  return $resource
}

function Get-VirtualMachine{
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

Export-ModuleMember -Function Get-VirtualMachine, Get-VirtualMachineExists
