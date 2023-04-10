---
external help file: BenchPress.Azure-help.xml
Module Name: BenchPress.Azure
online version:
schema: 2.0.0
---

# Confirm-AzBPDiagnosticSetting

## SYNOPSIS
Confirms that a Diagnostic Setting exists.

## SYNTAX

```
Confirm-AzBPDiagnosticSetting [-Name] <String> [-ResourceId] <String> [<CommonParameters>]
```

## DESCRIPTION
The Confirm-AzBPDiagnosticSetting cmdlet gets a Diagnostic Setting using the specified Diagnostic Setting name
and the specified Resource Id.

## EXAMPLES

### EXAMPLE 1
```
Confirm-AzBPDiagnosticSetting -Name "benchpresstest"
-ResourceId "/subscriptions/{subscriptionId}/resourceGroups/{rg}/providers/Microsoft.ContainerService/managedClusters/aksnqpog"
```

## PARAMETERS

### -Name
The name of the Diagnostic Setting.

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

### -ResourceId
The Id of the Resource.

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
