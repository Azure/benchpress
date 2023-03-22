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
Confirm-AzBPResource [-ResourceType] <ResourceType> [-ResourceName] <String> [[-ResourceGroupName] <String>]
 [[-NamespaceName] <String>] [[-EventHubName] <String>] [[-ServerName] <String>] [[-DataFactoryName] <String>]
 [[-WorkspaceName] <String>] [[-AccountName] <String>] [[-PropertyKey] <String>] [[-PropertyValue] <String>]
 [<CommonParameters>]
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
Checking whether a resource exists (i.e. Resource Group)
Confirm-AzBPResource -ResourceType $resourceType -ResourceName $resourceGroupName
```

### EXAMPLE 2
```
Confirm whether a resource has a property configured correctly (i.e. Resource Group located in West US 3)
Confirm-AzBPResource -ResourceType $resourceType -ResourceName $resourceGroupName -PropertyKey "Location" `
                      -PropertyValue "WestUS3"
```

### EXAMPLE 3
```
Checking whether a nested property on a resource is configured correctly (i.e. OS of VM is Linux)
```

$params = @{
  ResourceGroupName = "testrg";
  ResourceType = "VirtualMachine";
  ResourceName = "testvm";
  PropertyKey = "StorageProfile.OsDisk.OsType";
  PropertyValue = "Linux"
}

$result = Confirm-AzBPResource @params

## PARAMETERS

### -ResourceType
The type of the Resource as a \[ResourceType\]

```yaml
Type: ResourceType
Parameter Sets: (All)
Aliases:
Accepted values: ActionGroup, AksCluster, AppInsights, AppServicePlan, CosmosDBAccount, CosmosDBGremlinDatabase, CosmosDBMongoDBDatabase, CosmosDBSqlDatabase, ContainerRegistry, DataFactory, DataFactoryLinkedService, EventHub, EventHubConsumerGroup, EventHubNamespace, KeyVault, ResourceGroup, SqlDatabase, SqlServer, StorageAccount, StorageContainer, StreamAnalyticsCluster, StreamAnalyticsFunction, StreamAnalyticsInput, StreamAnalyticsJob, StreamAnalyticsOutput, StreamAnalyticsTransformation, SynapseSparkPool, SynapseSqlPool, SynapseWorkspace, VirtualMachine, WebApp

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceName
The name of the Resource

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceGroupName
The name of the Resource Group

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NamespaceName
{{ Fill NamespaceName Description }}

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

### -EventHubName
{{ Fill EventHubName Description }}

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

### -ServerName
If testing an Azure SQL Database resource, the name of the server to which the database is assigned.

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

### -DataFactoryName
If testing an Azure Data Factory Linked Service resource, the name of the data factory to which the linked
service is assigned.

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
If testing a resource that belongs to some sort of Azure workspace (i.e.
SQL pool in a Synapse workspace),
the name of the workspace to which the resource is assigned.

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
If the Azure resource has an associated account name (e.g., Cosmos DB SQL Database, Storage Container)

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

### -PropertyKey
The name of the property to check on the resource

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

### -PropertyValue
The expected value of the property to check

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### ResourceType
### System.String
## OUTPUTS

### ConfirmResult
## NOTES

## RELATED LINKS
