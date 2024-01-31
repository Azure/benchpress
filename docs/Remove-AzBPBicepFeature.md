---
external help file: BenchPress.Azure-help.xml
Module Name: BenchPress.Azure
online version: https://learn.microsoft.com/en-us/cli/azure/
schema: 2.0.0
---

# Remove-AzBPBicepFeature

## SYNOPSIS
Deletes Azure resources.

## SYNTAX

```
Remove-AzBPBicepFeature [-ResourceGroupName] <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Remove-AzBPBicepFeature cmdlet will take an Azure Resource Group name and delete that resource group and all
resources contained in it.

## EXAMPLES

### EXAMPLE 1
```
Remove-AzBPBicepFeature -ResourceGroupName "rg-test"
```

## PARAMETERS

### -ResourceGroupName
The name of the Resource Group to delete.
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

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
## OUTPUTS

### None
## NOTES

## RELATED LINKS
