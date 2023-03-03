# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1

. $PSScriptRoot/Confirm-ActionGroup.ps1
. $PSScriptRoot/Confirm-AksCluster.ps1
. $PSScriptRoot/Confirm-AppServicePlan.ps1
. $PSScriptRoot/Confirm-ContainerRegistry.ps1
. $PSScriptRoot/Confirm-KeyVault.ps1
. $PSScriptRoot/Confirm-OperationalInsightsWorkspace
. $PSScriptRoot/Confirm-ResourceGroup.ps1
. $PSScriptRoot/Confirm-SqlDatabase.ps1
. $PSScriptRoot/Confirm-SqlServer.ps1
. $PSScriptRoot/Confirm-VirtualMachine.ps1
. $PSScriptRoot/Confirm-WebApp.ps1
# end INLINE_SKIP

function Get-ResourceByType {
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

    .PARAMETER ServerName
      If testing an Azure SQL Database resource, the name of the server to which the database is assigned.

    .EXAMPLE
      Get-AzBPResourceByType -ResourceType ActionGroup -ResourceName "bpactiongroup" -ResourceGroupName "rgbenchpresstest"

    .EXAMPLE
      Get-AzBPResourceByType -ResourceType VirtualMachine -ResourceName "testvm" -ResourceGroupName "rgbenchpresstest"

    .INPUTS
      System.String

    .OUTPUTS
      ConfirmResult
  #>
  [CmdletBinding()]
  [OutputType([ConfirmResult])]
  param (
    [Parameter(Mandatory = $true)]
    [string]$ResourceName,

    [Parameter(Mandatory = $false)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory = $true)]
    [ValidateSet("ActionGroup", "AksCluster", "AppServicePlan", "ContainerRegistry", "KeyVault", "ResourceGroup",
      "OperationalInsightsWorkspace", "SqlDatabase", "SqlServer", "VirtualMachine", "WebApp")]
    [string]$ResourceType,

    [Parameter(Mandatory = $false)]
    [string]$ServerName
  )
  Begin { }
  Process {
    switch ($ResourceType) {
      "ActionGroup" {
        return Confirm-ActionGroup -ActionGroupName $ResourceName -ResourceGroupName $ResourceGroupName
      }
      "AksCluster" {
        return Confirm-AksCluster -AKSName $ResourceName -ResourceGroupName $0ResourceGroupName
      }
      "AppServicePlan" {
        return Confirm-AppServicePlan -AppServicePlanName $ResourceName -ResourceGroupName $ResourceGroupName
      }
      "ContainerRegistry" {
        return Confirm-ContainerRegistry -Name $ResourceName -ResourceGroupName $ResourceGroupName
      }
      "KeyVault" {
        return Confirm-KeyVault -Name $ResourceName -ResourceGroupName $ResourceGroupName
      }
      "OperationalInsightsWorkspace" {
        return Confirm-OperationalInsightsWorkspace -Name $ResourceName -ResourceGroupName $ResourceGroupName
      }
      "ResourceGroup" {
        return Confirm-ResourceGroup -ResourceGroupName $ResourceName
      }
      "SqlDatabase" {
        $params = @{
          ServerName        = $ServerName
          DatabaseName      = $ResourceName
          ResourceGroupName = $ResourceGroupName
        }
        return Confirm-SqlDatabase @params
      }
      "SqlServer" {
        return Confirm-SqlServer -ServerName $ResourceName -ResourceGroupName $ResourceGroupName
      }
      "VirtualMachine" {
        return Confirm-VirtualMachine -VirtualMachineName $ResourceName -ResourceGroupName $ResourceGroupName
      }
      "WebApp" {
        return Confirm-WebApp -WebAppName $ResourceName -ResourceGroupName $ResourceGroupName
      }
      default {
        Write-Information "Not implemented yet"
        return $null
      }
    }
  }
  End { }
}
