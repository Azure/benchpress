# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1
using module ./../Classes/ResourceType.psm1

. $PSScriptRoot/Confirm-ActionGroup.ps1
. $PSScriptRoot/Confirm-AksCluster.ps1
. $PSScriptRoot/Confirm-AppInsights.ps1
. $PSScriptRoot/Confirm-AppServicePlan.ps1
. $PSScriptRoot/Confirm-ContainerRegistry.ps1
. $PSScriptRoot/Confirm-DataFactory.ps1
. $PSScriptRoot/Confirm-DataFactoryLinkedService.ps1
. $PSScriptRoot/Confirm-EventHub.ps1
. $PSScriptRoot/Confirm-EventHubConsumerGroup.ps1
. $PSScriptRoot/Confirm-EventHubNamespace.ps1
. $PSScriptRoot/Confirm-KeyVault.ps1
. $PSScriptRoot/Confirm-OperationalInsightsWorkspace.ps1
. $PSScriptRoot/Confirm-ResourceGroup.ps1
. $PSScriptRoot/Confirm-SqlDatabase.ps1
. $PSScriptRoot/Confirm-SqlServer.ps1
. $PSScriptRoot/Confirm-StorageAccount.ps1
. $PSScriptRoot/Confirm-StorageContainer.ps1
. $PSScriptRoot/Confirm-StreamAnalyticsCluster.ps1
. $PSScriptRoot/Confirm-SynapseSparkPool.ps1
. $PSScriptRoot/Confirm-SynapseSqlPool.ps1
. $PSScriptRoot/Confirm-SynapseWorkspace.ps1
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
      The type of the Resource.

    .PARAMETER ServerName
      If testing an Azure SQL Database resource, the name of the server to which the database is assigned.

    .PARAMETER DataFactoryName
      If testing an Azure Data Factory Linked Service resource, the name of the data factory to which the linked
      service is assigned.

    .PARAMETER WorkspaceName
      If testing a resource that belongs to some sort of Azure workspace (i.e. SQL pool in a Synapse workspace),
      the name of the workspace to which the resource is assigned.

    .PARAMETER AccountName
      If the Azure resource has an associated account name (e.g., Cosmos DB SQL Database, Storage Container) this is
      the parameter to use to pass the account name.

    .PARAMETER ServiceName
      If the Azure resource is associated with a service (e.g, API Management Service) this is the parameter to use to
      pass the service name.

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
    [Parameter(Mandatory = $false)]
    [string]$ResourceName,

    [Parameter(Mandatory = $false)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory = $true)]
    [ResourceType]$ResourceType,

    [Parameter(Mandatory = $false)]
    [string]$ServerName,

    [Parameter(Mandatory = $false)]
    [string]$DataFactoryName,

    [Parameter(Mandatory = $false)]
    [string]$NamespaceName,

    [Parameter(Mandatory = $false)]
    [string]$EventHubName,

    [Parameter(Mandatory = $false)]
    [string]$WorkspaceName,

    [Parameter(Mandatory = $false)]
    [string]$AccountName,

    [Parameter(Mandatory = $false)]
    [string]$ServiceName
  )
  Begin { }
  Process {
    switch ($ResourceType) {
      "ActionGroup" {
        return Confirm-ActionGroup -ActionGroupName $ResourceName -ResourceGroupName $ResourceGroupName
      }
      "AksCluster" {
        return Confirm-AksCluster -AKSName $ResourceName -ResourceGroupName $ResourceGroupName
      }
      "ApiManagement" {
        return Confirm-ApiManagement -ResourceGroupName $ResourceGroupName -Name $ResourceName
      }
      "ApiManagementApi" {
        $params = @{
          ResourceGroupName = $ResourceGroupName
          ServiceName = $ServiceName
          Name = $ResourceName
        }
        return Confirm-ApiManagementApi @params
      }
      "ApiManagementDiagnostic" {
        $params = @{
          ResourceGroupName = $ResourceGroupName
          ServiceName = $ServiceName
          Name = $ResourceName
        }
        return Confirm-ApiManagementDiagnostic @params
      }
      "ApiManagementLogger" {
        $params = @{
          ResourceGroupName = $ResourceGroupName
          ServiceName = $ServiceName
          Name = $ResourceName
        }
        return Confirm-ApiManagementLogger @params
      }
      "ApiManagementPolicy" {
        $params = @{
          ResourceGroupName = $ResourceGroupName
          ServiceName = $ServiceName
          ApiId = $ResourceName
        }
        return Confirm-ApiManagementPolicy @params
      }
      "AppInsights" {
        return Confirm-AppInsights -ResourceGroupName $ResourceGroupName -Name $ResourceName
      }
      "AppServicePlan" {
        return Confirm-AppServicePlan -AppServicePlanName $ResourceName -ResourceGroupName $ResourceGroupName
      }
      "ContainerApp" {
        return Confirm-ContainerApp -ResourceGroupName $ResourceGroupName -Name $ResourceName
      }
      "ContainerAppManagedEnv" {
        return Confirm-ContainerAppManagedEnv -ResourceGroupName $ResourceGroupName -Name $ResourceName
      }
      "ContainerRegistry" {
        return Confirm-ContainerRegistry -Name $ResourceName -ResourceGroupName $ResourceGroupName
      }
      "CosmosDBAccount" {
        return Confirm-CosmosDBAccount -ResourceGroupName $ResourceGroupName -Name $AccountName
      }
      "CosmosDBGremlinDatabase" {
        $params = @{
          ResourceGroupName = $ResourceGroupName
          AccountName       = $AccountName
          Name              = $ResourceName
        }
        return Confirm-CosmosDBGremlinDatabase @params
      }
      "CosmosDBMongoDBDatabase" {
        $params = @{
          ResourceGroupName = $ResourceGroupName
          AccountName       = $AccountName
          Name              = $ResourceName
        }
        return Confirm-CosmosDBMongoDBDatabase @params
      }
      "CosmosDBSqlDatabase" {
        $params = @{
          ResourceGroupName = $ResourceGroupName
          AccountName       = $AccountName
          Name              = $ResourceName
        }
        return Confirm-CosmosDBSqlDatabase @params
      }
      "DataFactory" {
        return Confirm-DataFactory -Name $ResourceName -ResourceGroupName $ResourceGroupName
      }
      "DataFactoryLinkedService" {
        $params = @{
          Name              = $ResourceName
          DataFactoryName   = $DataFactoryName
          ResourceGroupName = $ResourceGroupName
        }
        return Confirm-DataFactoryLinkedService @params
      }
      "EventHub" {
        $params = @{
          Name              = $ResourceName
          NamespaceName     = $NamespaceName
          ResourceGroupName = $ResourceGroupName
        }
        return Confirm-EventHub @params
      }
      "EventHubConsumerGroup" {
        $params = @{
          Name              = $ResourceName
          EventHubName      = $EventHubName
          NamespaceName     = $NamespaceName
          ResourceGroupName = $ResourceGroupName
        }
        return Confirm-EventHubConsumerGroup @params
      }
      "EventHubNamespace" {
        return Confirm-EventHubNamespace -NamespaceName $ResourceName -ResourceGroupName $ResourceGroupName
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
      "StorageAccount" {
        return Confirm-StorageAccount -Name $ResourceName -ResourceGroupName $ResourceGroupName
      }
      "StorageContainer" {
        $params = @{
          Name              = $ResourceName
          AccountName       = $AccountName
          ResourceGroupName = $ResourceGroupName
        }
        return Confirm-StorageContainer @params
      }
      "StreamAnalyticsCluster" {
        return Confirm-StreamAnalyticsCluster -Name $ResourceName -ResourceGroupName $ResourceGroupName
      }
      "StreamAnalyticsFunction" {
        $params = @{
          ResourceGroupName = $ResourceGroupName
          JobName = $JobName
          Name = $Name
        }
        return Confirm-StreamAnalyticsFunction @params
      }
      "StreamAnalyticsInput" {
        $params = @{
          ResourceGroupName = $ResourceGroupName
          JobName = $JobName
          Name = $Name
        }
        return Confirm-StreamAnalyticsInput @params
      }
      "StreamAnalyticsJob" {
        return Confirm-StreamAnalyticsJob -ResourceGroupName $ResourceGroupName -Name $ResourceName
      }
      "StreamAnalyticsOutput" {
        $params = @{
          ResourceGroupName = $ResourceGroupName
          JobName = $JobName
          Name = $Name
        }
        return Confirm-StreamAnalyticsOutput @params
      }
      "StreamAnalyticsTransformation" {
        $params = @{
          ResourceGroupName = $ResourceGroupName
          JobName = $JobName
          Name = $Name
        }
        return Confirm-StreamAnalyticsTransformation @params
      }
      "SynapseSparkPool" {
        $params = @{
          SynapseSparkPoolName = $ResourceName
          WorkspaceName        = $WorkspaceName
          ResourceGroupName    = $ResourceGroupName
        }
        return Confirm-SynapseSparkPool @params
      }
      "SynapseSqlPool" {
        $params = @{
          SynapseSqlPoolName = $ResourceName
          WorkspaceName      = $WorkspaceName
          ResourceGroupName  = $ResourceGroupName
        }
        return Confirm-SynapseSqlPool @params
      }
      "SynapseWorkspace" {
        return Confirm-SynapseWorkspace -WorkspaceName $ResourceName -ResourceGroupName $ResourceGroupName
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
