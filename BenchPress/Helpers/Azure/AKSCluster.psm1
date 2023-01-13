function Get-AKSCluster {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$aksName,

    [Parameter(Mandatory=$true)]
    [string]$resourceGroupName
  )

  $resource = Get-AzAksCluster -ResourceGroupName $resourceGroupName -Name $aksName
  return $resource
}

function Get-AKSClusterExists {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$aksName,

    [Parameter(Mandatory=$true)]
    [string]$resourceGroupName
  )

  $resource = Get-AKSCluster -aksName $aksName -resourceGroupName $resourceGroupName
  return ($null -ne $resource)
}

Export-ModuleMember -Function `
  Get-AKSCluster, Get-AKSClusterExists
