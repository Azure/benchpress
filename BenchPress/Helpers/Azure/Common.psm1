Import-Module "../BenchPress/Helpers/Azure/ResourceGroup.psm1"
Import-Module "../BenchPress/Helpers/Azure/ServicePlan.psm1"
Import-Module "../BenchPress/Helpers/Azure/SqlServer.psm1"
Import-Module "../BenchPress/Helpers/Azure/SqlDatabase.psm1"
Import-Module "../BenchPress/Helpers/Azure/VirtualMachine.psm1"
Import-Module "../BenchPress/Helpers/Azure/WebApp.psm1"

enum ResourceType {
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
    ResourceGroup { return Get-ResourceGroup($ResourceName) }
    ServicePlan { return Get-ServicePlan($ResourceName, $ResourceGroupName) }
    SqlDatabase { return Get-SqlDatabase($ResourceName, $ResourceGroupName) }
    SqlServer { return Get-SqlServer($ResourceName, $ResourceGroupName) }
    VirtualMachine { return Get-VirtualMachine($ResourceName, $ResourceGroupName) }
    WebApp { return Get-WebApp($ResourceName, $ResourceGroupName) }
    default { Write-Host "Not implemented yet" return $null }
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

Export-ModuleMember -Function `
  Get-Resource, Get-ResourceByType
