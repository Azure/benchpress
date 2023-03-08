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
Confirm-AzBPResource [-ResourceType] <String> [-ResourceName] <String> [[-ResourceGroupName] <String>]
 [[-ServerName] <String>] [[-PropertyKey] <String>] [[-PropertyValue] <String>] [<CommonParameters>]
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
The type of the Resource (currently supports the following:
ActionGroup
AksCluster
AppInsights
AppServicePlan
ContainerRegistry
KeyVault
ResourceGroup
SqlDatabase
SqlServer
VirtualMachine
WebApp)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

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

### -ServerName
If testing an Azure SQL Database resource, the name of the server to which the database is assigned.

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

### -PropertyKey
The name of the property to check on the resource

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

### -PropertyValue
The expected value of the property to check

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### ResourceType
### System.String
## OUTPUTS

### ConfirmResult
## NOTES

## RELATED LINKS
