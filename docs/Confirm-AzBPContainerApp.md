---
external help file: BenchPress.Azure-help.xml
Module Name: BenchPress.Azure
online version:
schema: 2.0.0
---

# Confirm-AzBPContainerApp

## SYNOPSIS
Confirms that a Container Application exists.

## SYNTAX

```
Confirm-AzBPContainerApp [-Name] <String> [-ResourceGroupName] <String> [<CommonParameters>]
```

## DESCRIPTION
The Confirm-AzBPContainerApp cmdlet gets a Container Application using the specified Container Application and
Resource Group name.

## EXAMPLES

### EXAMPLE 1
```
Confirm-AzBPContainerApp -Name "benchpresstest" -ResourceGroupName "rgbenchpresstest"
```

## PARAMETERS

### -Name
The name of the Container Application

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
