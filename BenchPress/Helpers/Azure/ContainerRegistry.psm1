<#
.SYNOPSIS
  Helper function for Container Registry

.DESCRIPTION
  Helper function for Container Registry

.PARAMETER Name
  The name of the Container Registry

.PARAMETER ResourceGroupName
  The name of the resource group

.EXAMPLE
  Get-ContainerRegistry -Name "benchpresstest" -ResourceGroupName "rgbenchpresstest"
#>
function Get-ContainerRegistry {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$Name,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )

  $resource = Get-AzContainerRegistry -ResourceGroupName $ResourceGroupName -Name $Name
  return $resource
}

<#
.SYNOPSIS
  Helper function for Container Registry

.DESCRIPTION
  Helper function for Container Registry

.PARAMETER Name
  The name of the Container Registry

.PARAMETER ResourceGroupName
  The name of the resource group

.EXAMPLE
  Get-ContainerRegistry-Name "benchpresstest" -ResourceGroupName "rgbenchpresstest"
#>
function Get-ContainerRegistryExist {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$Name,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )
  $resource = Get-ContainerRegistry -Name $Name -ResourceGroupName $ResourceGroupName
  return ($null -ne $resource)
}

Export-ModuleMember -Function Get-ContainerRegistry, Get-ContainerRegistryExist
