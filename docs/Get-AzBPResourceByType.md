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
Get-AzBPResourceByType [-ResourceName] <String> [[-ResourceGroupName] <String>] [-ResourceType] <String>
 [[-ServerName] <String>] [<CommonParameters>]
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
The name of the Resource

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

### -ResourceGroupName
The name of the Resource Group

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
The type of the Resource (currently support the following:
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
## OUTPUTS

### ConfirmResult
## NOTES

## RELATED LINKS
