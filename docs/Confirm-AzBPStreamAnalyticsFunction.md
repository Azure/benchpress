---
external help file: BenchPress.Azure-help.xml
Module Name: BenchPress.Azure
online version:
schema: 2.0.0
---

# Confirm-AzBPStreamAnalyticsFunction

## SYNOPSIS
Confirms that a Stream Analytics Function exists.

## SYNTAX

```
Confirm-AzBPStreamAnalyticsFunction [-ResourceGroupName] <String> [-JobName] <String> [-Name] <String>
 [<CommonParameters>]
```

## DESCRIPTION
The Confirm-AzBPStreamAnalyticsFunction cmdlet gets a Stream Analytics Function using the specified Resource
Group, the Job executing the Function, and the Function names.

## EXAMPLES

### EXAMPLE 1
```
Confirm-AzBPStreamAnalyticsFunction -ResourceGroupName "rgbenchpresstest" -JobName "jn" -Name "benchpresstest"
```

## PARAMETERS

### -ResourceGroupName
The name of the Resource Group.
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

### -JobName
The name of the Streaming Job.

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
The name of the Function.

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
