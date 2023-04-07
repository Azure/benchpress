---
external help file: BenchPress.Azure-help.xml
Module Name: BenchPress.Azure
online version:
schema: 2.0.0
---

# Confirm-AzBPCosmosDBSqlRoleDefinition

## SYNOPSIS
Confirms that a CosmosDB Sql Role Definition exists.

## SYNTAX

```
Confirm-AzBPCosmosDBSqlRoleDefinition [-ResourceGroupName] <String> [-AccountName] <String>
 [-RoleDefinitionId] <String> [<CommonParameters>]
```

## DESCRIPTION
The Confirm-AzBPCosmosDBSqlRoleDefinition cmdlet gets a CosmosDB Sql Role Definition
using the specified Resource Group Name, Cosmos DB Account Name and Role Definition Id.

## EXAMPLES

### EXAMPLE 1
```
$params = @{
  ResourceGroupName = "rgbenchpresstest"
  AccountName       = "an"
  RoleDefinitionId  = "roledefinitionid"
}
```

Confirm-AzBPCosmosDBSqlRoleDefinition @params

## PARAMETERS

### -ResourceGroupName
The name of the Resource Group.
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

### -AccountName
The name of the Cosmos DB Account.

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

### -RoleDefinitionId
The Id of the Role Definition.

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
