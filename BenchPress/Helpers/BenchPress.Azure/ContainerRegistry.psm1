Import-Module $PSScriptRoot/Authentication.psm1

<#
.SYNOPSIS
  Gets a Container Registry.

.DESCRIPTION
  The Get-AzBPContainerRegistry cmdlet gets a Container Registry using the specified Container Registry and
  Resource Group name.

.PARAMETER Name
  The name of the Container Registry

.PARAMETER ResourceGroupName
  The name of the Resource Group

.EXAMPLE
  Get-AzBPContainerRegistry -Name "benchpresstest" -ResourceGroupName "rgbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  Microsoft.Azure.Commands.ContainerRegistry.PSContainerRegistry
#>
function Get-ContainerRegistry {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$Name,

    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )

  Connect-Account

  $resource = Get-AzContainerRegistry -ResourceGroupName $ResourceGroupName -Name $Name
  return $resource
}

<#
.SYNOPSIS
  Gets if a Container Registry exists.

.DESCRIPTION
  The Get-AzBPContainerRegistryExist cmdlet checks if a Container Registry exists using the specified
  Container Registry and Resource Group name.

.PARAMETER Name
  The name of the Container Registry

.PARAMETER ResourceGroupName
  The name of the Resource Group

.EXAMPLE
  Get-AzBPContainerRegistryExist -Name "benchpresstest" -ResourceGroupName "rgbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  System.Boolean
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
