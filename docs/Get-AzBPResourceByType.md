---
external help file: BenchPress.Azure-help.xml
Module Name: BenchPress.Azure
online version:
schema: 2.0.0
---

# Get-AzBPResourceByType

## SYNOPSIS
Gets an Azure Resource.

## SYNTAX

```
Get-AzBPResourceByType [[-ResourceName] <String>] [[-ResourceGroupName] <String>]
 [-ResourceType] <ResourceType> [[-ServerName] <String>] [[-DataFactoryName] <String>]
 [[-NamespaceName] <String>] [[-EventHubName] <String>] [[-WorkspaceName] <String>] [[-AccountName] <String>]
 [[-ServicePrincipalId] <String>] [[-Scope] <String>] [[-RoleDefinitionName] <String>]
 [[-ServiceName] <String>] [[-ClusterName] <String>] [[-JobName] <String>] [<CommonParameters>]
```

## DESCRIPTION
The Get-AzBPResourceByType cmdlet gets an Azure resource depending on the resource type (i.e.
Action Group, Key Vault,
Container Registry, etc.).

## EXAMPLES

### EXAMPLE 1
```
Get-AzBPResourceByType -ResourceType ActionGroup -ResourceName "bpactiongroup" -ResourceGroupName "rgbenchpresstest"
```

### EXAMPLE 2
```
Get-AzBPResourceByType -ResourceType VirtualMachine -ResourceName "testvm" -ResourceGroupName "rgbenchpresstest"
```

## PARAMETERS

### -ResourceName
The name of the Resource.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceGroupName
The name of the Resource Group.
The name is case insensitive.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceType
The type of the Resource.

```yaml
Type: ResourceType
Parameter Sets: (All)
Aliases:
Accepted values: ActionGroup, AksCluster, AksNodePool, ApiManagement, ApiManagementApi, ApiManagementDiagnostic, ApiManagementLogger, ApiManagementPolicy, AppInsights, AppServicePlan, ContainerApp, ContainerAppManagedEnv, CosmosDBAccount, CosmosDBGremlinDatabase, CosmosDBMongoDBDatabase, CosmosDBSqlDatabase, ContainerRegistry, DataFactory, DataFactoryLinkedService, EventHub, EventHubConsumerGroup, EventHubNamespace, KeyVault, OperationalInsightsWorkspace, PortalDashboard, ResourceGroup, RoleAssignment, SqlDatabase, SqlServer, StorageAccount, StorageContainer, StreamAnalyticsCluster, StreamAnalyticsFunction, StreamAnalyticsInput, StreamAnalyticsJob, StreamAnalyticsOutput, StreamAnalyticsTransformation, SynapseSparkPool, SynapseSqlPool, SynapseWorkspace, VirtualMachine, WebApp, WebAppStaticSite

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ServerName
If testing an Azure SQL Database resource, the name of the Server to which the Database is assigned.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DataFactoryName
If testing an Azure Data Factory Linked Service resource, the name of the Data Factory to which the Linked
Service is assigned.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NamespaceName
If testing an Azure resource that is associated with a Namespace (e.g., Event Hub), the name of the associated
Namespace.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EventHubName
If testing a component of Event Hub (e.g., Consumer Group), the name of the Event Hub to which the component
is assigned.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WorkspaceName
If testing an Azure resource that belongs to some sort of Azure Workspace (e.g., SQL Pool in a Synapse
Workspace), the name of the Workspace to which the resource is assigned.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AccountName
If testing an Azure resource that is associated with an Account (e.g., Cosmos DB SQL Database,
Storage Container), the name of the associated Account.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ServicePrincipalId
If testing an Azure Role Assignment, the Application ID of the Service Principal.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Scope
If testing an Azure Role Assignment, the Scope of the Role Assignment (e.g.,
/subscriptions/{id}/resourceGroups/{resourceGroupName}).
It must start with "/subscriptions/{id}".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RoleDefinitionName
If testing an Azure Role Assignment, the name of the Role Definition (e.g., Reader, Contributor etc.).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ServiceName
If testing an Azure resource that is associated with a Service (e.g., API Management Service), the name of
the associated Service.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ClusterName
If the Azure resource is associated with an AKS Cluster (e.g, AKS Node Pool) this is the parameter to use to pass
the AKS cluster name.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -JobName
If testing an Azure resource that is associated with a Job (e.g., Stream Analytics Output), the name of
the associated Job.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
## OUTPUTS

### ConfirmResult
## NOTES

## RELATED LINKS
