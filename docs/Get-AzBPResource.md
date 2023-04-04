---
external help file: BenchPress.Azure-help.xml
Module Name: BenchPress.Azure
online version:
schema: 2.0.0
---

# Get-AzBPResource

## SYNOPSIS
Gets one or more resources of a given name.

## SYNTAX

```
Get-AzBPResource [-ResourceName] <String> [[-ResourceGroupName] <String>] [<CommonParameters>]
```

## DESCRIPTION
The Get-AzBPResource cmdlet gets Azure resources of a given name.

## EXAMPLES

### EXAMPLE 1
```
Get-AzBPResource -ResourceName "benchpresstest"
```

### EXAMPLE 2
```
Get-AzBPResource -ResourceName "benchpresstest" -ResourceGroupName "rgbenchpresstest"
```

## PARAMETERS

### -ResourceName
The name of the Resource.

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
The name of the Resource Group.
The name is case insensitive.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
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

### Microsoft.Azure.Commands.ResourceManager.Cmdlets.SdkModels.PSResource
## NOTES

## RELATED LINKS
