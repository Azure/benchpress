---
external help file: BenchPress.Azure-help.xml
Module Name: BenchPress.Azure
online version:
schema: 2.0.0
---

# Confirm-AzBPKeyVaultSecret

## SYNOPSIS
Confirms that a Key Vault Secret exists.

## SYNTAX

```
Confirm-AzBPKeyVaultSecret [-Name] <String> [-KeyVaultName] <String> [<CommonParameters>]
```

## DESCRIPTION
The Confirm-AzBPKeyVaultSecret cmdlet gets a Key Vault Secret using the specified Key Vault and Secret name.

## EXAMPLES

### EXAMPLE 1
```
Confirm-AzBPKeyVaultSecret -Name "benchpresstest" -KeyVaultName "kvbenchpresstest"
```

## PARAMETERS

### -Name
The name of the Secret.

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

### -KeyVaultName
The name of the Key Vault.

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
