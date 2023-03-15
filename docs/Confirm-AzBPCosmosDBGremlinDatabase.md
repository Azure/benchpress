---
external help file: BenchPress.Azure-help.xml
Module Name: BenchPress.Azure
online version:
schema: 2.0.0
---

# Confirm-AzBPCosmosDBGremlinDatabase

## SYNOPSIS
Confirms that a Cosmos DB Gremlin Database exists.

## SYNTAX

```
Confirm-AzBPCosmosDBGremlinDatabase [-ResourceGroupName] <String> [-AccountName] <String> [-Name] <String>
 [<CommonParameters>]
```

## DESCRIPTION
The Confirm-AzBPCosmosDBGremlinDatabase cmdlet gets Cosmos DB Gremlin database given the Resource Group Name, the
name of the Cosmos DB Account, and the name of the Gremlin Database.

## EXAMPLES

### EXAMPLE 1
```
Confirm-AzBPCosmosDBGremlinDatabase -ResourceGroupName "rgbenchpresstest" -AccountName "an" -Name "gremlindb"
```

## PARAMETERS

### -ResourceGroupName
The name of the Resource Group.

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

### -AccountName
The Cosmos DB account name.

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

### -Name
The name of the Cosmos DB Gremlin Database

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
## OUTPUTS

### ConfirmResult
## NOTES

## RELATED LINKS
