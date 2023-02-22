using module ./public/classes/ConfirmResult.psm1

Import-Module $PSScriptRoot/ActionGroup.psm1
Import-Module $PSScriptRoot/AksCluster.psm1
Import-Module $PSScriptRoot/AppServicePlan.psm1
Import-Module $PSScriptRoot/Authentication.psm1
Import-Module $PSScriptRoot/ContainerRegistry.psm1
Import-Module $PSScriptRoot/KeyVault.psm1
Import-Module $PSScriptRoot/ResourceGroup.psm1
Import-Module $PSScriptRoot/SqlServer.psm1
Import-Module $PSScriptRoot/SqlDatabase.psm1
Import-Module $PSScriptRoot/VirtualMachine.psm1
Import-Module $PSScriptRoot/WebApp.psm1

enum ResourceType {
  ActionGroup
  AksCluster
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
  AksCluster
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
  ConfirmResult
#>
function Get-ResourceByType {
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory = $true)]
    [string]$ResourceName,

    [Parameter(Mandatory = $false)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory = $true)]
    [ResourceType]$ResourceType
  )

  switch ($ResourceType) {
    ActionGroup { return Confirm-ActionGroup -ActionGroupName $ResourceName -ResourceGroupName $ResourceGroupName }
    AksCluster { return Confirm-AksCluster -AKSName $ResourceName -ResourceGroupName $ResourceGroupName }
    AppServicePlan { return Confirm-AppServicePlan -AppServicePlanName $ResourceName -ResourceGroupName $ResourceGroupName }
    ContainerRegistry { return Confirm-ContainerRegistry -Name $ResourceName -ResourceGroupName $ResourceGroupName }
    KeyVault { return Confirm-KeyVault -Name $ResourceName -ResourceGroupName $ResourceGroupName }
    ResourceGroup { return Confirm-ResourceGroup -ResourceGroupName $ResourceName }
    SqlDatabase { return Confirm-SqlDatabase -ServerName $ResourceName -ResourceGroupName $ResourceGroupName }
    SqlServer { return Confirm-SqlServer -ServerName $ResourceName -ResourceGroupName $ResourceGroupName }
    VirtualMachine { return Confirm-VirtualMachine -VirtualMachineName $ResourceName -ResourceGroupName $ResourceGroupName }
    WebApp { return Confirm-WebApp -WebAppName $ResourceName -ResourceGroupName $ResourceGroupName }
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

  Connect-Account

  if ([string]::IsNullOrEmpty($ResourceGroupName)) {
    return Get-AzResource -Name "${ResourceName}"
  }
  else {
    return Get-AzResource -Name "${ResourceName}" -ResourceGroupName "${ResourceGroupName}"
  }
}


<#
  .SYNOPSIS
    Confirms whether a resource exists or properties on a resource are configured correctly.

  .DESCRIPTION
    The Confirm-AzBPResource cmdlet confirms whether an Azure resource exists and/or confirms whether properties
    on a resource exist and are configured to the correct value. The cmdlet will return a ConfirmResult object
    which contains the following properties:
    - Success: True if the resource exists and/or the property is set to the expected value. Otherwise, false.
    - Error: System.Management.Automation.ErrorRecord containing an ErrorRecord with a message explaining
             that a resource did not exist or property was not set to the expected value.
    - ResourceDetails: System.Object that contains the details of the Azure Resource that is being confirmed.

  .PARAMETER ResourceName
    The name of the Resource

  .PARAMETER ResourceGroupName
    The name of the Resource Group

  .PARAMETER ResourceType
    The type of the Resource (currently supports the following:
    ActionGroup
    AksCluster
    AppServicePlan
    ContainerRegistry
    KeyVault
    ResourceGroup
    SqlDatabase
    SqlServer
    VirtualMachine
    WebApp)

  .PARAMETER PropertyKey
    The name of the property to check on the resource

  .PARAMETER PropertyValue
    The expected value of the property to check

  .EXAMPLE
    Checking whether a resource exists (i.e. Resource Group)
    Confirm-AzBPResource -ResourceType $resourceType -ResourceName $resourceGroupName

  .EXAMPLE
    Confirm whether a resource has a property configured correctly (i.e. Resource Group located in West US 3)
    Confirm-AzBPResource -ResourceType $resourceType -ResourceName $resourceGroupName -PropertyKey "Location" `
                         -PropertyValue "WestUS3"
  .INPUTS
    ResourceType
    System.String

  .OUTPUTS
    ConfirmResult
#>
function Confirm-Resource {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [ResourceType]$ResourceType,

    [Parameter(Mandatory = $true)]
    [string]$ResourceName,

    [Parameter(Mandatory = $false)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory = $false)]
    [string]$PropertyKey,

    [Parameter(Mandatory = $false)]
    [string]$PropertyValue

  )

  $ResourceParams = @{
    ResourceGroupName = $ResourceGroupName
    ResourceName = $ResourceName
    ResourceType = $ResourceType
  }

  $ConfirmResult = Get-ResourceByType @ResourceParams

  if ($null -eq $ConfirmResult) {
    $ErrorRecord = Format-ErrorRecord -Message "ResourceType is invalid" -ErrorID "InvalidResourceType"
    $ConfirmResult = [ConfirmResult]::new($ErrorRecord, $null)
  } elseif ($ConfirmResult.Success) {
    if ($PropertyKey) {
      if ($ConfirmResult.ResourceDetails.$PropertyKey -ne $PropertyValue) {
        $ConfirmResult.Success = $false
        $ConfirmResult.ErrorRecord = `
          Format-IncorrectValueError -ExpectedKey $PropertyKey `
                                     -ExpectedValue $PropertyValue `
                                     -ActualResult $ConfirmResult.ResourceDetails.$PropertyKey
      }
    }
  }

  $ConfirmResult
}


<#
  .SYNOPSIS
    Private function to create a message and ErrorRecord for when a resource does not exist.

  .DESCRIPTION
    Format-NotExistError is a private helper function that can be used to construct a message and ErrorRecord
    for when a resource does not exist.

  .PARAMETER Expected
    The name of the resource that was expected to exist.

  .EXAMPLE
    Format-NotExistError -Expected "MyVM"

  .INPUTS
    System.String

  .OUTPUTS
    System.Management.Automation.ErrorRecord
#>
function Format-NotExistError([string]$Expected) {
  $Message = "Expected $Expected to exist, but it does not exist."
  return Format-ErrorRecord -Message $Message -ErrorID "BenchPressExistFail"
}

<#
  .SYNOPSIS
    Private function to create a message and ErrorRecord for when a resource property is not set correctly.

  .DESCRIPTION
    Format-IncorrectValueError is a private helper function that can be used to construct a message and ErrorRecord
    for when a resource property is not set to the expected value.

  .PARAMETER ExpectedKey
    The resource property name that is checked

  .PARAMETER ExpectedValue
    The expected value of the resource property

  .PARAMETER ActualValue
    The actual value of the resource property

  .EXAMPLE
    Format-IncorrectValueError -ExpectedKey "Location" -ExpectedValue "WestUS3" -ActualValue "EastUS"

  .INPUTS
    System.String

  .OUTPUTS
    System.Management.Automation.ErrorRecord
#>
function Format-IncorrectValueError([string]$ExpectedKey, [string]$ExpectedValue, [string]$ActualValue) {
  $Message = "Expected $ExpectedKey to be $ExpectedValue, but got $ActualValue"
  return Format-ErrorRecord -Message $Message -ErrorID "BenchPressValueFail"
}

<#
  .SYNOPSIS
    Private function to help construct a ErrorRecord.

  .DESCRIPTION
    Format-ErrorRecord is a private helper function that can be used to construct an ErrorRecord.

  .PARAMETER Message
    Message for the ErrorRecord

  .PARAMETER ErrorID
    A string that can be used to uniquily identify the ErrorRecord.

  .EXAMPLE
    Format-ErrorRecord -Message $incorrectValueMessage -ErrorID "BenchPressValueFail"

  .INPUTS
    System.String

  .OUTPUTS
    System.Management.Automation.ErrorRecord
#>
function Format-ErrorRecord ([string] $Message, [string]$ErrorID) {
  $Exception = [Exception] $Message
  $ErrorCategory = [System.Management.Automation.ErrorCategory]::InvalidResult
  $TargetObject = @{ Message = $Message }
  $ErrorRecord = New-Object System.Management.Automation.ErrorRecord $Exception, $ErrorID, $ErrorCategory, $TargetObject
  return $ErrorRecord
}

Export-ModuleMember -Function Get-Resource, Get-ResourceByType, Confirm-Resource, `
  Format-NotExistError, Format-IncorrectValueError, Format-ErrorRecord
