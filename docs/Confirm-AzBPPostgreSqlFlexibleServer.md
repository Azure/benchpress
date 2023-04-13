---
external help file: BenchPress.Azure-help.xml
Module Name: BenchPress.Azure
online version:
schema: 2.0.0
---

# Confirm-AzBPPostgreSqlFlexibleServer

## SYNOPSIS
Confirms that a PostgreSQL Flexible Server exists.

## SYNTAX

```
Confirm-AzBPPostgreSqlFlexibleServer [-ResourceGroupName] <String> [-Name] <String> [<CommonParameters>]
```

## DESCRIPTION
The Confirm-AzBPPostgreSqlFlexibleServer cmdlet gets a PostgreSQL Flexible Server using the specified PostgreSQL
Server Name and the Resource Group name.

## EXAMPLES

### EXAMPLE 1
```
Confirm-AzBPPostgreSqlFlexibleServer -ResourceGroupName "rgbenchpresstest" -Name "benchpresstest"
```

## PARAMETERS

### -ResourceGroupName
The name of the resource group.
The name is case insensitive.

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
The name of the server.

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
