<#
.SYNOPSIS
  Helper function for AKS Cluster

.DESCRIPTION
  Helper function for AKS Cluster

.PARAMETER AKSName
  The name of the AKS Cluster

.PARAMETER ResourceGroupName
  The name of the resource group

.EXAMPLE
  Get-AKSCluster -AKSName "benchpresstest" -ResourceGroupName "rgbenchpresstest"
#>
function Get-AKSCluster {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$AKSName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )

  $resource = Get-AzAksCluster -ResourceGroupName $ResourceGroupName -Name $AKSName
  Write-Host $resource
  return $resource
}

<#
.SYNOPSIS
  Helper function for AKS Cluster

.DESCRIPTION
  Helper function for AKS Cluster

.PARAMETER AKSName
  The name of the AKS Cluster

.PARAMETER ResourceGroupName
  The name of the resource group

.EXAMPLE
  Get-AKSClusterExist -AKSName "benchpresstest" -ResourceGroupName "rgbenchpresstest"
#>
function Get-AKSClusterExist {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$AKSName,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )

  $resource = Get-AKSCluster -AKSName $AKSName -ResourceGroupName $ResourceGroupName
  return ($null -ne $resource)
}

Export-ModuleMember -Function Get-AKSCluster, Get-AKSClusterExist
