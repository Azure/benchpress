Import-Module $PSScriptRoot/ResourceGroup.psm1
Import-Module $PSScriptRoot/ServicePlan.psm1
Import-Module $PSScriptRoot/SqlServer.psm1
Import-Module $PSScriptRoot/SqlDatabase.psm1
Import-Module $PSScriptRoot/VirtualMachine.psm1
Import-Module $PSScriptRoot/WebApp.psm1

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
    ResourceGroup { return Get-ResourceGroup -resourceGroupName $ResourceName }
    ServicePlan { return Get-AppServicePlan -appServicePlanName $ResourceName -resourceGroupName $ResourceGroupName }
    SqlDatabase { return Get-SqlDatabase -serverName $ResourceName -resourceGroupName $ResourceGroupName }
    SqlServer { return Get-SqlServer -serverName $ResourceName -resourceGroupName $ResourceGroupName }
    VirtualMachine { return Get-VirtualMachine -virtualMachineName $ResourceName -resourceGroupName $ResourceGroupName }
    WebApp { return Get-WebApp -webAppName $ResourceName -resourceGroupName $ResourceGroupName }
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
