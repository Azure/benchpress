Import-Module $PSScriptRoot/ActionGroup.psm1
Import-Module $PSScriptRoot/AKSCluster.psm1
Import-Module $PSScriptRoot/ContainerRegistry.psm1
Import-Module $PSScriptRoot/KeyVault.psm1
Import-Module $PSScriptRoot/ResourceGroup.psm1
Import-Module $PSScriptRoot/ServicePlan.psm1
Import-Module $PSScriptRoot/SqlServer.psm1
Import-Module $PSScriptRoot/SqlDatabase.psm1
Import-Module $PSScriptRoot/VirtualMachine.psm1
Import-Module $PSScriptRoot/WebApp.psm1

enum ResourceType {
  ActionGroup
  AKSCluster
  ContainerRegistry
  KeyVault
  ResourceGroup
  ServicePlan
  SqlDatabase
  SqlServer
  VirtualMachine
  WebApp
}

function Get-ResourceByType {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceName,

    [Parameter(Mandatory=$false)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory=$true)]
    [ResourceType]$ResourceType
  )

  switch ($ResourceType)
  {
    ActionGroup { return Get-ActionGroup -ActionGroupName $ResourceName -ResourceGroupName $ResourceGroupName }
    AKSCluster { return Get-AKSCluster -AKSName $ResourceName -ResourceGroupName $ResourceGroupName }
    ContainerRegistry { return Get-ContainerRegistry -Name $ResourceName -ResourceGroupName $ResourceGroupName }
    KeyVault { return Get-KeyVault -Name $ResourceName -ResourceGroupName $ResourceGroupName }
    ResourceGroup { return Get-ResourceGroup -ResourceGroupName $ResourceName }
    ServicePlan { return Get-AppServicePlan -AppServicePlanName $ResourceName -ResourceGroupName $ResourceGroupName }
    SqlDatabase { return Get-SqlDatabase -ServerName $ResourceName -ResourceGroupName $ResourceGroupName }
    SqlServer { return Get-SqlServer -ServerName $ResourceName -ResourceGroupName $ResourceGroupName }
    VirtualMachine { return Get-VirtualMachine -VirtualMachineName $ResourceName -ResourceGroupName $ResourceGroupName }
    WebApp { return Get-WebApp -WebAppName $ResourceName -ResourceGroupName $ResourceGroupName }
    default {
      Write-Information "Not implemented yet"
      return $null
    }
  }
}

function Get-Resource {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceName,

    [Parameter(Mandatory=$false)]
    [string]$ResourceGroupName
  )

  return Get-AzResource -Name "${ResourceName}" -ResourceGroupName "${ResourceGroupName}"
}

Export-ModuleMember -Function Get-Resource, Get-ResourceByType
