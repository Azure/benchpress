---
external help file: BenchPress.Azure-help.xml
Module Name: BenchPress.Azure
online version:
schema: 2.0.0
---

# Confirm-AzBPStorageContainer

## SYNOPSIS
Confirms that a Storage Container exists.

## SYNTAX

```
Confirm-AzBPStorageContainer [-Name] <String> [-AccountName] <String> [-ResourceGroupName] <String>
 [<CommonParameters>]
```

## DESCRIPTION
The Confirm-AzBPStorageContainer cmdlet gets a Storage Container using the specified Storage Account, Container
and Resource Group name.

## EXAMPLES

### EXAMPLE 1
```
Confirm-AzBPStorageContainer -Name "teststgcontainer" -AccountName "teststgacct" -ResourceGroupName "testrg"
```

## PARAMETERS

### -Name
The name of the Storage Container

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
The name of the Storage Account

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
