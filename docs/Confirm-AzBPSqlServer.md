---
external help file: BenchPress.Azure-help.xml
Module Name: BenchPress.Azure
online version:
schema: 2.0.0
---

# Confirm-AzBPSqlServer

## SYNOPSIS
Confirms that a SQL Server exists.

## SYNTAX

```
Confirm-AzBPSqlServer [-ServerName] <String> [-ResourceGroupName] <String> [<CommonParameters>]
```

## DESCRIPTION
The Confirm-AzBPSqlServer cmdlet gets a SQL Server using the specified SQL Server and
Resource Group name.

## EXAMPLES

### EXAMPLE 1
```
Confirm-AzBPSqlServer -ServerName "testserver" -ResourceGroupName "rgbenchpresstest"
```

## PARAMETERS

### -ServerName
The name of the SQL Server

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
