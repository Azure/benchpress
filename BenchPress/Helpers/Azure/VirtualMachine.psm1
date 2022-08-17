function Get-VirtualMachine([string]$virtualMachineName, [string]$resourceGroupName) {
  $resource = Get-AzVM -ResourceGroupName $resourceGroupName -Name $virtualMachineName
  return $resource
}

function Get-VirtualMachineExists([string]$virtualMachineName, [string]$resourceGroupName) {
  $resource = Get-VirtualMachine $virtualMachineName $resourceGroupName
  return ($null -ne $resource)
}

Export-ModuleMember -Function `
  Get-VirtualMachine, Get-VirtualMachineExists
