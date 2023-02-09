Import-Module $PSScriptRoot/ActionGroup.psm1
Import-Module $PSScriptRoot/AKSCluster.psm1
Import-Module $PSScriptRoot/AppServicePlan.psm1
Import-Module $PSScriptRoot/ContainerRegistry.psm1
Import-Module $PSScriptRoot/KeyVault.psm1
Import-Module $PSScriptRoot/ResourceGroup.psm1
Import-Module $PSScriptRoot/SqlServer.psm1
Import-Module $PSScriptRoot/SqlDatabase.psm1
Import-Module $PSScriptRoot/VirtualMachine.psm1
Import-Module $PSScriptRoot/WebApp.psm1

enum ResourceType {
  ActionGroup
  AKSCluster
  AppServicePlan
  ContainerRegistry
  KeyVault
  ResourceGroup
  SqlDatabase
  SqlServer
  VirtualMachine
  WebApp
}

<#
.SYNOPSIS
  Gets an Azure Resource.

.DESCRIPTION
  The Get-AzBPResourceByType cmdlet gets an Azure resource depending on the resource type (i.e. Action Group, Key Vault,
  Container Registry, etc.).

.PARAMETER ResourceName
  The name of the Resource

.PARAMETER ResourceGroupName
  The name of the Resource Group

.PARAMETER ResourceType
  The type of the Resource (currently support the following:
  ActionGroup
  AKSCluster
  AppServicePlan
  ContainerRegistry
  KeyVault
  ResourceGroup
  SqlDatabase
  SqlServer
  VirtualMachine
  WebApp)

.EXAMPLE
  Get-AzBPResourceByType -ResourceType ActionGroup -ResourceName "bpactiongroup" -ResourceGroupName "rgbenchpresstest"

.EXAMPLE
  Get-AzBPResourceByType -ResourceType VirtualMachine -ResourceName "testvm" -ResourceGroupName "rgbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  Microsoft.Azure.Commands.ResourceManager.Cmdlets.SdkModels.PSResource
#>
function Get-ResourceByType {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]$ResourceName,

    [Parameter(Mandatory = $false)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory = $true)]
    [ResourceType]$ResourceType
  )

  switch ($ResourceType) {
    ActionGroup { return Get-ActionGroup -ActionGroupName $ResourceName -ResourceGroupName $ResourceGroupName }
    AKSCluster { return Get-AKSCluster -AKSName $ResourceName -ResourceGroupName $ResourceGroupName }
    AppServicePlan { return Get-AppServicePlan -AppServicePlanName $ResourceName -ResourceGroupName $ResourceGroupName }
    ContainerRegistry { return Get-ContainerRegistry -Name $ResourceName -ResourceGroupName $ResourceGroupName }
    KeyVault { return Get-KeyVault -Name $ResourceName -ResourceGroupName $ResourceGroupName }
    ResourceGroup { return Get-ResourceGroup -ResourceGroupName $ResourceName }
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

<#
.SYNOPSIS
  Gets one or more resources of a given name.

.DESCRIPTION
  The Get-AzBPResource cmdlet gets Azure resources of a given name.

.PARAMETER ResourceName
  The name of the Resources

.PARAMETER ResourceGroupName
  The name of the Resource Group

.EXAMPLE
  Get-AzBPResource -ResourceName "benchpresstest"

.EXAMPLE
  Get-AzBPResource -ResourceName "benchpresstest" -ResourceGroupName "rgbenchpresstest"

.INPUTS
  System.String

.OUTPUTS
  Microsoft.Azure.Commands.ResourceManager.Cmdlets.SdkModels.PSResource
#>
function Get-Resource {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]$ResourceName,

    [Parameter(Mandatory = $false)]
    [string]$ResourceGroupName
  )

  if ([string]::IsNullOrEmpty($ResourceGroupName)) {
    return Get-AzResource -Name "${ResourceName}"
  }
  else {
    return Get-AzResource -Name "${ResourceName}" -ResourceGroupName "${ResourceGroupName}"
  }
}

class Result {
  <# Define the class. Try constructors, properties, or methods. #>
  [boolean]$StatusCode
  [System.Management.Automation.ErrorRecord]$Error
  [System.Object]$ResourceObj
}

function Confirm-Resource {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $false)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory = $false)]
    [ResourceType]$ResourceType,

    [Parameter(Mandatory = $false)]
    [string]$ResourceName,

    [Parameter(Mandatory = $false)]
    [string]$PropertyKey,

    [Parameter(Mandatory = $false)]
    [string]$PropertyValue

  )

  $resourceResult = [Result]::new()
  switch ($ResourceType) {
    ContainerRegistry { $resourceResult.ResourceObj = Get-ContainerRegistry -Name $ResourceName -ResourceGroupName $ResourceGroupName }
    ResourceGroup { $resourceResult.ResourceObj = Get-ResourceGroup -ResourceGroupName $ResourceName }
    VirtualMachine { $resourceResult.ResourceObj = Get-VirtualMachine -VirtualMachineName $ResourceName -ResourceGroupName $ResourceGroupName }
  }

  if ($null -ne $resourceResult.ResourceObj) {
    $resourceResult.StatusCode = $true
  }
  else {
    $resourceResult.StatusCode = $false
    $resourceResult.Error = NotExistError -Expected $ResourceName
    return $resourceResult
  }

  if($PropertyKey){
    if($resourceResult.ResourceObj.$PropertyKey -ne $PropertyValue){
      $resourceResult.StatusCode = $false
      $resourceResult.Error = IncorrectValueError -ExpectedKey $PropertyKey -ExpectedValue $PropertyValue -Actual $resourceResult
    }
  }
  return $resourceResult
}

function NotExistError([string]$Expected) {
  $message = "Expected $Expected to exist, but it does not exist."
  return New-ErrorRecord -Message $message -ErrorID "BenchPressExistFail"
}

function IncorrectValueError([string]$ExpectedKey, [string]$ExpectedValue, [Result]$Actual) {
  $message = "Expected $ExpectedKey to be $ExpectedValue, but got $($Actual.ResourceObj.$ExpectedKey)"
  return New-ErrorRecord -Message $message -ErrorID "BenchPressValueFail"
}

function New-ErrorRecord ([string] $Message, [string]$ErrorID) {
  $exception = [Exception] $Message
  $errorCategory = [System.Management.Automation.ErrorCategory]::InvalidResult
  # we use ErrorRecord.TargetObject to pass structured information about the error to a reporting system.
  $targetObject = @{ Message = $Message; }
  $errorRecord = New-Object System.Management.Automation.ErrorRecord $exception, $ErrorID, $errorCategory, $targetObject
  return $errorRecord
}

Export-ModuleMember -Function Get-Resource, Get-ResourceByType, Confirm-Resource
