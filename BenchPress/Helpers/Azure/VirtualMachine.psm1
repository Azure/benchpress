function Get-VirtualMachine {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$virtualMachineName,

    [Parameter(Mandatory=$true)]
    [string]$resourceGroupName
  )

  $resource = Get-AzVM -ResourceGroupName $resourceGroupName -Name $virtualMachineName
  return $resource
}

function Get-VirtualMachineExists {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$virtualMachineName,

    [Parameter(Mandatory=$true)]
    [string]$resourceGroupName
  )

  $resource = Get-VirtualMachine $virtualMachineName $resourceGroupName
  return ($null -ne $resource)
}

Export-ModuleMember -Function `
  Get-VirtualMachine, Get-VirtualMachineExists
