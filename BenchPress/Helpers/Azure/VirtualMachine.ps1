function Get-VirtualMachineExists([string]$virtualMachineName) {
  $vm = Get-AzVM -Name $virtualMachineName
  if ($null -eq $vm) {
    throw "Virtual machine $virtualMachineName was not found!"
  }
  else{
    return $true
  }
}
