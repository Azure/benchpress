# INLINE_SKIP
using module ./../Classes/ConfirmResult.psm1
using module ./../Classes/ResourceType.psm1

. $PSScriptRoot/Confirm-ActionGroup.ps1
. $PSScriptRoot/Confirm-AksCluster.ps1
. $PSScriptRoot/Confirm-AksNodePool.ps1
. $PSScriptRoot/Confirm-AppInsights.ps1
. $PSScriptRoot/Confirm-AppServicePlan.ps1
. $PSScriptRoot/Confirm-ContainerAppManagedEnv
. $PSScriptRoot/Confirm-ContainerRegistry.ps1
. $PSScriptRoot/Confirm-DataFactory.ps1
. $PSScriptRoot/Confirm-DataFactoryLinkedService.ps1
. $PSScriptRoot/Confirm-EventHub.ps1
. $PSScriptRoot/Confirm-EventHubConsumerGroup.ps1
. $PSScriptRoot/Confirm-EventHubNamespace.ps1
. $PSScriptRoot/Confirm-KeyVault.ps1
. $PSScriptRoot/Confirm-OperationalInsightsWorkspace.ps1
. $PSScriptRoot/Confirm-PostgreSqlFlexibleServer
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
      The name of the Resource.

    .PARAMETER ResourceGroupName
      The name of the Resource Group. The name is case insensitive.

    .PARAMETER ResourceType
      The type of the Resource.

    .PARAMETER ServerName
      If testing an Azure SQL Database resource, the name of the Server to which the Database is assigned.

    .PARAMETER DataFactoryName
      If testing an Azure Data Factory Linked Service resource, the name of the Data Factory to which the Linked
      Service is assigned.

    .PARAMETER NamespaceName
      If testing an Azure resource that is associated with a Namespace (e.g., Event Hub), the name of the associated
      Namespace.

    .PARAMETER EventHubName
      If testing a component of Event Hub (e.g., Consumer Group), the name of the Event Hub to which the component
      is assigned.

    .PARAMETER WorkspaceName
      If testing an Azure resource that belongs to some sort of Azure Workspace (e.g., SQL Pool in a Synapse
      Workspace), the name of the Workspace to which the resource is assigned.

    .PARAMETER AccountName
      If testing an Azure resource that is associated with an Account (e.g., Cosmos DB SQL Database,
      Storage Container), the name of the associated Account.

    .PARAMETER ServicePrincipalId
      If testing an Azure Role Assignment, the Application ID of the Service Principal.

    .PARAMETER Scope
      If testing an Azure Role Assignment, the Scope of the Role Assignment (e.g.,
      /subscriptions/{id}/resourceGroups/{resourceGroupName}).
      It must start with "/subscriptions/{id}".

    .PARAMETER RoleDefinitionName
      If testing an Azure Role Assignment, the name of the Role Definition (e.g., Reader, Contributor etc.).

    .PARAMETER ServiceName
      If testing an Azure resource that is associated with a Service (e.g., API Management Service), the name of
      the associated Service.

    .PARAMETER JobName
      If testing an Azure resource that is associated with a Job (e.g., Stream Analytics Output), the name of
      the associated Job.

    .PARAMETER ClusterName
      If the Azure resource is associated with an AKS Cluster (e.g, AKS Node Pool) this is the parameter to use to pass
      the AKS cluster name.

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
    [string]$ServicePrincipalId,

    [Parameter(Mandatory = $false)]
    [string]$Scope,

    [Parameter(Mandatory = $false)]
    [string]$RoleDefinitionName,

    [Parameter(Mandatory = $false)]
    [string]$ServiceName,

    [Parameter(Mandatory = $false)]
    [string]$ClusterName,

    [Parameter(Mandatory = $false)]
    [string]$JobName
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
      "AksNodePool" {
        $params = @{
          ResourceGroupName = $ResourceGroupName
          ClusterName       = $ClusterName
          Name              = $ResourceName
        }
        return Confirm-AksNodePool @params
      }
      "ApiManagement" {
        return Confirm-ApiManagement -ResourceGroupName $ResourceGroupName -Name $ResourceName
      }
      "ApiManagementApi" {
        $params = @{
          ResourceGroupName = $ResourceGroupName
          ServiceName       = $ServiceName
          Name              = $ResourceName
        }
        return Confirm-ApiManagementApi @params
      }
      "ApiManagementDiagnostic" {
        $params = @{
          ResourceGroupName = $ResourceGroupName
          ServiceName       = $ServiceName
          Name              = $ResourceName
        }
        return Confirm-ApiManagementDiagnostic @params
      }
      "ApiManagementLogger" {
        $params = @{
          ResourceGroupName = $ResourceGroupName
          ServiceName       = $ServiceName
          Name              = $ResourceName
        }
        return Confirm-ApiManagementLogger @params
      }
      "ApiManagementPolicy" {
        $params = @{
          ResourceGroupName = $ResourceGroupName
          ServiceName       = $ServiceName
          ApiId             = $ResourceName
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
        return Confirm-CosmosDBAccount -ResourceGroupName $ResourceGroupName -Name $ResourceName
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
      "PostgreSqlFlexibleServer" {
        return Confirm-PostgreSqlFlexibleServer -ResourceGroupName $ResourceGroupName -Name $ResourceName
      }
      "ResourceGroup" {
        return Confirm-ResourceGroup -ResourceGroupName $ResourceName
      }
      "RoleAssignment" {
        $params = @{
          ServicePrincipalId   = $ServicePrincipalId
          RoleDefinitionName   = $RoleDefinitionName
          Scope                = $Scope
        }
        return Confirm-RoleAssignment @params
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
          JobName           = $JobName
          Name              = $ResourceName
        }
        return Confirm-StreamAnalyticsFunction @params
      }
      "StreamAnalyticsInput" {
        $params = @{
          ResourceGroupName = $ResourceGroupName
          JobName           = $JobName
          Name              = $ResourceName
        }
        return Confirm-StreamAnalyticsInput @params
      }
      "StreamAnalyticsJob" {
        return Confirm-StreamAnalyticsJob -ResourceGroupName $ResourceGroupName -Name $ResourceName
      }
      "StreamAnalyticsOutput" {
        $params = @{
          ResourceGroupName = $ResourceGroupName
          JobName           = $JobName
          Name              = $ResourceName
        }
        return Confirm-StreamAnalyticsOutput @params
      }
      "StreamAnalyticsTransformation" {
        $params = @{
          ResourceGroupName = $ResourceGroupName
          JobName           = $JobName
          Name              = $ResourceName
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
