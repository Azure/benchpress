<#
.SYNOPSIS
  Gets an AKS Cluster.

.DESCRIPTION
  The Get-AzBPAKSCluster cmdlet gets an AKS cluster using the specified AKS Cluster and Resource Group name.

.PARAMETER AKSName
  The name of the AKS Cluster

.PARAMETER ResourceGroupName
  The name of the Resource Group

.EXAMPLE
  Get-AzBPAKSCluster -AKSName "benchpresstest" -ResourceGroupName "rgbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  Microsoft.Azure.Commands.Aks.Models.PSKubernetesCluster
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
  return $resource
}

<#
.SYNOPSIS
  Gets if an AKS Cluster exists.

.DESCRIPTION
  The Get-AzBPAKSClusterExist cmdlet checks if an AKS cluster exists using the specified AKS Cluster and
  Resource Group name.

.PARAMETER AKSName
  The name of the AKS Cluster

.PARAMETER ResourceGroupName
  The name of the Resource Group

.EXAMPLE
  Get-AzBPAKSClusterExist -AKSName "benchpresstest" -ResourceGroupName "rgbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  System.Boolean
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




