function Get-ContainerRegistry {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$Name,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )

  $resource = Get-AzContainerRegistry -ResourceGroupName $resourceGroupName -Name $Name
  return $resource
}

function Get-ContainerRegistryExists {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$Name,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  $resource = Get-ContainerRegistry -Name $Name -ResourceGroupName $resourceGroupName
  return ($null -ne $resource)
}

Export-ModuleMember -Function `
  Get-ContainerRegistry, Get-ContainerRegistryExists
