---
external help file: BenchPress.Azure-help.xml
Module Name: BenchPress.Azure
online version:
schema: 2.0.0
---

# Confirm-AzBPCosmosDBAccount

## SYNOPSIS
Confirms that a Cosmos DB Account exists.

## SYNTAX

```
Confirm-AzBPCosmosDBAccount [-ResourceGroupName] <String> [-Name] <String> [<CommonParameters>]
```

## DESCRIPTION
The Confirm-AzBPCosmosDBAccount cmdlet gets Cosmos DB Account given the Resource Group Name and the name of the
Cosmos DB Account.

## EXAMPLES

### EXAMPLE 1
```
Confirm-AzBPCosmosDBAccount -Name "benchpresstest" -ResourceGroupName "rgbenchpresstest"
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

### -Name
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
## OUTPUTS

### ConfirmResult
## NOTES

## RELATED LINKS
