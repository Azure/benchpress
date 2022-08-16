function Get-ResourceGroup([string]$resourceGroupName) {
  $resource = Get-AzResourceGroup $resourceGroupName
  return $resource
}

function Get-ResourceGroupExists([string]$resourceGroupName) {
  $resource = Get-ResourceGroup $resourceGroupName

  return ($null -ne $resource)
}

Export-ModuleMember -Function `
  Get-ResourceGroup, Get-ResourceGroupExists
