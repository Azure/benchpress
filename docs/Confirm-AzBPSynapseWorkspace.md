---
external help file: BenchPress.Azure-help.xml
Module Name: BenchPress.Azure
online version:
schema: 2.0.0
---

# Confirm-AzBPSynapseWorkspace

## SYNOPSIS
Confirms that a Synapse Workspace exists.

## SYNTAX

```
Confirm-AzBPSynapseWorkspace [-WorkspaceName] <String> [-ResourceGroupName] <String> [<CommonParameters>]
```

## DESCRIPTION
The Confirm-AzBPSynapseWorkspace cmdlet gets a synapse workspace using the specified Synapse Workspace and
Resource Group name.

## EXAMPLES

### EXAMPLE 1
```
Confirm-AzBPSynapseWorkspace -WorkspaceName "benchpresstest" -ResourceGroupName "rgbenchpresstest"
```

## PARAMETERS

### -WorkspaceName
The name of the Synapse Workspace

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
