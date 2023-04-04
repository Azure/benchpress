---
external help file: BenchPress.Azure-help.xml
Module Name: BenchPress.Azure
online version:
schema: 2.0.0
---

# Confirm-AzBPKeyVaultCertificate

## SYNOPSIS
Confirms that a Key Vault Certificate exists.

## SYNTAX

```
Confirm-AzBPKeyVaultCertificate [-Name] <String> [-KeyVaultName] <String> [<CommonParameters>]
```

## DESCRIPTION
The Confirm-AzBPKeyVaultCertificate cmdlet gets a Key Vault Certificate using the specified Key Vault and
Certificate name.

## EXAMPLES

### EXAMPLE 1
```
Confirm-AzBPKeyVaultCertificate -Name "benchpresstest" -KeyVaultName "kvbenchpresstest"
```

## PARAMETERS

### -Name
The name of the Certificate.

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
