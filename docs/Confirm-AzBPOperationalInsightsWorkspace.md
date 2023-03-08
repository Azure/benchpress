---
external help file: BenchPress.Azure-help.xml
Module Name: BenchPress.Azure
online version:
schema: 2.0.0
---

# Confirm-AzBPOperationalInsightsWorkspace

## SYNOPSIS
Confirms that an Operational Insights Workspace exists.

## SYNTAX

```
Confirm-AzBPOperationalInsightsWorkspace [-Name] <String> [-ResourceGroupName] <String> [<CommonParameters>]
```

## DESCRIPTION
The Confirm-AzBPOperationalInsightsWorkspace cmdlet gets an Operational Insights Workspace using the specified
Workspace Name and Resource Group name.

## EXAMPLES

### EXAMPLE 1
```
Confirm-AzBPOperationalInsightsWorkspace -Name "benchpresstest" -ResourceGroupName "rgbenchpresstest"
```

## PARAMETERS

### -Name
Specifies the workspace name.

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
Specifies the name of an Azure resource group.

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
