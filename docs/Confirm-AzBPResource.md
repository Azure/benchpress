---
external help file: BenchPress.Azure-help.xml
Module Name: BenchPress.Azure
online version:
schema: 2.0.0
---

# Confirm-AzBPResource

## SYNOPSIS
Confirms whether a resource exists or properties on a resource are configured correctly.

## SYNTAX

```
Confirm-AzBPResource [[-ResourceName] <String>] [[-ResourceGroupName] <String>] [-ResourceType] <ResourceType>
 [[-ServerName] <String>] [[-DataFactoryName] <String>] [[-NamespaceName] <String>] [[-EventHubName] <String>]
 [[-WorkspaceName] <String>] [[-ServicePrincipalId] <String>] [[-Scope] <String>]
 [[-RoleDefinitionName] <String>] [[-AccountName] <String>] [[-ServiceName] <String>] [[-ClusterName] <String>]
 [[-JobName] <String>] [[-PropertyKey] <String>] [[-PropertyValue] <String>] [<CommonParameters>]
```

## DESCRIPTION
The Confirm-AzBPResource cmdlet confirms whether an Azure resource exists and/or confirms whether properties
on a resource exist and are configured to the correct value.
The cmdlet will return a ConfirmResult object
which contains the following properties:
- Success: True if the resource exists and/or the property is set to the expected value.
Otherwise, false.
- ResourceDetails: System.Object that contains the details of the Azure Resource that is being confirmed.

## EXAMPLES

### EXAMPLE 1
```
Checking whether a resource exists (i.e. Resource Group).
Confirm-AzBPResource -ResourceType $resourceType -ResourceName $resourceGroupName
```

### EXAMPLE 2
```
Confirm whether a resource has a property configured correctly (i.e. Resource Group located in West US 3).
Confirm-AzBPResource -ResourceType $resourceType -ResourceName $resourceGroupName -PropertyKey "Location" `
                      -PropertyValue "WestUS3"
```

### EXAMPLE 3
```
Checking whether a nested property on a resource is configured correctly (i.e. OS of VM is Linux).
```

$params = @{
  ResourceGroupName = "rg-test";
  ResourceType = "VirtualMachine";
  ResourceName = "testvm";
  PropertyKey = "StorageProfile.OsDisk.OsType";
  PropertyValue = "Linux"
}

$result = Confirm-AzBPResource @params

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
The type of the Resource as a \[ResourceType\].

```yaml
Type: ResourceType
Parameter Sets: (All)
Aliases:
Accepted values: ActionGroup, AksCluster, AksNodePool, ApiManagement, ApiManagementApi, ApiManagementDiagnostic, ApiManagementLogger, ApiManagementPolicy, AppInsights, AppServicePlan, ContainerApp, ContainerAppManagedEnv, CosmosDBAccount, CosmosDBGremlinDatabase, CosmosDBMongoDBDatabase, CosmosDBSqlDatabase, ContainerRegistry, DataFactory, DataFactoryLinkedService, EventHub, EventHubConsumerGroup, EventHubNamespace, KeyVault, OperationalInsightsWorkspace, PortalDashboard, ResourceGroup, RoleAssignment, SqlDatabase, SqlServer, StorageAccount, StorageContainer, StreamAnalyticsCluster, StreamAnalyticsFunction, StreamAnalyticsInput, StreamAnalyticsJob, StreamAnalyticsOutput, StreamAnalyticsTransformation, SynapseSparkPool, SynapseSqlPool, SynapseWorkspace, VirtualMachine, WebApp

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

### -ServicePrincipalId
If testing an Azure Role Assignment, the Application ID of the Service Principal.

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

### -Scope
If testing an Azure Role Assignment, the Scope of the Role Assignment (e.g.,
/subscriptions/{id}/resourceGroups/{resourceGroupName}).
It must start with "/subscriptions/{id}".

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

### -RoleDefinitionName
If testing an Azure Role Assignment, the name of the Role Definition (e.g., Reader, Contributor etc.).

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

### -AccountName
If testing an Azure resource that is associated with an Account (e.g., Cosmos DB SQL Database,
Storage Container), the name of the associated Account.

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

### -PropertyKey
The name of the property to check on the resource.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PropertyValue
The expected value of the property to check.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### ResourceType
### System.String
## OUTPUTS

### ConfirmResult
## NOTES

## RELATED LINKS
