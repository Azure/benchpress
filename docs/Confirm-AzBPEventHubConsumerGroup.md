---
external help file: BenchPress.Azure-help.xml
Module Name: BenchPress.Azure
online version:
schema: 2.0.0
---

# Confirm-AzBPEventHubConsumerGroup

## SYNOPSIS
Confirms that an EventHub ConsumerGroup exists.

## SYNTAX

```
Confirm-AzBPEventHubConsumerGroup [-Name] <String> [-NamespaceName] <String> [-EventHubName] <String>
 [-ResourceGroupName] <String> [<CommonParameters>]
```

## DESCRIPTION
The Confirm-AzBPEventHubConsumerGroup cmdlet gets an Event Hub Consumer Group using the specified Event Hub
Consumer Group, Event Hub Namespace, Event Hub, and Resource Group names.

## EXAMPLES

### EXAMPLE 1
```
Confirm-AzBPEventHubConsumerGroup -Name 'consumergrouptest' -NamespaceName 'bpeventhubnamespace' -EventHubName 'bpeventhub' -ResourceGroupName "rgbenchpresstest"
```

## PARAMETERS

### -Name
The name of the Event Hub Consumer Group.

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

### -NamespaceName
The name of the Event Hub Namespace.

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

### -EventHubName
The name of the Event Hub.

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

### -ResourceGroupName
The name of the Resource Group.
The name is case insensitive.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
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