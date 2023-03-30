---
external help file: BenchPress.Azure-help.xml
Module Name: BenchPress.Azure
online version:
schema: 2.0.0
---

# Confirm-AzBPApiManagementPolicy

## SYNOPSIS
Confirms that an API Management Policy exists.

## SYNTAX

```
Confirm-AzBPApiManagementPolicy [-ResourceGroupName] <String> [-ServiceName] <String> [-ApiId] <String>
 [<CommonParameters>]
```

## DESCRIPTION
The Confirm-AzBPApiManagementPolicy cmdlet gets an API Management Policy using the specified API, API Management
Service, and Resource Group names.

## EXAMPLES

### EXAMPLE 1
```
Confirm-AzBPApiManagementPolicy -ResourceGroupName "rgbenchpresstest" -ServiceName "servicetest" `
  -ApiId "benchpresstest"
```

## PARAMETERS

### -ResourceGroupName
Specifies the name of the resource group under which an API Management service is deployed.

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

### -ServiceName
Specifies the name of the deployed API Management service.

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

### -ApiId
Specifies the identifier of the existing API.
This cmdlet returns the API-scope policy.

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
