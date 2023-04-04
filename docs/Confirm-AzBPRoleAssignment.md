---
external help file: BenchPress.Azure-help.xml
Module Name: BenchPress.Azure
online version:
schema: 2.0.0
---

# Confirm-AzBPRoleAssignment

## SYNOPSIS
Confirms that a Role Assignment for a service principal exists.

## SYNTAX

```
Confirm-AzBPRoleAssignment [-RoleDefinitionName] <String> [-ServicePrincipalId] <String> [-Scope] <String>
 [<CommonParameters>]
```

## DESCRIPTION
The Confirm-AzBPRoleAssignment cmdlet gets a Role Assignment using the specified Service Prinicpal, Scope,
and Role Assignment names.

## EXAMPLES

### EXAMPLE 1
```
Confirm-AzBPRoleAssignment -RoleDefinitionName Reader -ServicePrincipalName testId `
-Scope /subscriptions/{id}/resourceGroups/{resourceGroupName}
```

## PARAMETERS

### -RoleDefinitionName
The name of the Role Definition i.e.
Reader, Contributor etc.

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

### -ServicePrincipalId
The Application ID of the Service Principal.

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

### -Scope
The Scope of the Role Assignment.
In the format of relative URI.
For e.g.
/subscriptions/{id}/resourceGroups/{resourceGroupName}.
It must start with "/subscriptions/{id}".

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
