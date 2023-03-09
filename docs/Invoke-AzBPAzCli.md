---
external help file: BenchPress.Azure-help.xml
Module Name: BenchPress.Azure
online version: https://learn.microsoft.com/en-us/cli/azure/
schema: 2.0.0
---

# Invoke-AzBPAzCli

## SYNOPSIS
Invoke-AzBPAzCli cmdlet invokes an Azure CLI command and returns the result as an object.

## SYNTAX

```
Invoke-AzBPAzCli [-Command] <String> [<CommonParameters>]
```

## DESCRIPTION
Invoke an Azure CLI command.

## EXAMPLES

### EXAMPLE 1
```
Invoke-AzBPAzCli "account list"
```

### EXAMPLE 2
```
Invoke-AzBPAzCli "account list --query [].name"
```

### EXAMPLE 3
```
Invoke-AzBPAzCli "webapp create --name ${WEBAPP_NAME} --resource-group ${RESOURCE_GROUP_NAME} --plan ${APP_SERVICE_PLAN_NAME}"
```

## PARAMETERS

### -Command
The command to execute.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
## OUTPUTS

### System.Object
## NOTES
Invoke-AzBPAzCli adds the az prefix to the command.

## RELATED LINKS

[https://learn.microsoft.com/en-us/cli/azure/](https://learn.microsoft.com/en-us/cli/azure/)

[https://learn.microsoft.com/en-us/cli/azure/get-started-with-azure-cli](https://learn.microsoft.com/en-us/cli/azure/get-started-with-azure-cli)

[https://learn.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest](https://learn.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest)

