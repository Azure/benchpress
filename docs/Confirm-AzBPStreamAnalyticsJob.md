---
external help file: BenchPress.Azure-help.xml
Module Name: BenchPress.Azure
online version:
schema: 2.0.0
---

# Confirm-AzBPStreamAnalyticsJob

## SYNOPSIS
Confirms that a Stream Analytics Job exists.

## SYNTAX

```
Confirm-AzBPStreamAnalyticsJob [-ResourceGroupName] <String> [-Name] <String> [<CommonParameters>]
```

## DESCRIPTION
The Confirm-AzBPStreamAnalyticsJob cmdlet gets a Stream Analytics Job using the specified Resource Group and
Stream Analytics Job names.

## EXAMPLES

### EXAMPLE 1
```
Confirm-AzBPStreamAnalyticsCluster -ResourceGroupName "rgbenchpresstest" -Name "benchpresstest"
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

### -Name
The name of the Stream Analytics Job.

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
