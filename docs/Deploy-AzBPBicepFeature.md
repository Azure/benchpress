---
external help file: BenchPress.Azure-help.xml
Module Name: BenchPress.Azure
online version:
schema: 2.0.0
---

# Deploy-AzBPBicepFeature

## SYNOPSIS
Deploys Azure resources using a bicep file.

## SYNTAX

```
Deploy-AzBPBicepFeature [-BicepPath] <String> [-Params] <Hashtable> [[-ResourceGroupName] <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Deploy-AzBPBicepFeature cmdlet deploys Azure resources when given a path to a bicep file.
The cmdlet will
transpile the bicep file to an ARM template and uses the ARM template to deploy to Azure.

## EXAMPLES

### EXAMPLE 1
```
$params = @{
  name           = "acrbenchpresstest1"
  location       = "westus3"
}
Deploy-AzBPBicepFeature -BicepPath "./containerRegistry.bicep" -Params $params -ResourceGroupName "rg-test"
```

## PARAMETERS

### -BicepPath
This is the path to the bicep file that will be used to transpile to ARM and deploy to Azure.

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

### -Params
{{ Fill Params Description }}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceGroupName
{{ Fill ResourceGroupName Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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
### System.Collections.Hashtable
## OUTPUTS

### None
## NOTES

## RELATED LINKS
