---
external help file: BenchPress.Azure-help.xml
Module Name: BenchPress.Azure
online version:
schema: 2.0.0
---

# Confirm-AzBPBicepFile

## SYNOPSIS
Confirm-AzBPBicepFile will confirm that the bicep files provided pass the checks executed by \`bicep build\`.

## SYNTAX

```
Confirm-AzBPBicepFile [-BicepFilePath] <String[]> [<CommonParameters>]
```

## DESCRIPTION
Confirm-AzBPBicepFile executes \`bicep build\` and returns an object that has an array field Errors.
Each element
of this array is an object that contains the bicep file path that had errors and a collection of
System.Object.ErrorRecord that correspond to the file at that path:

{Errors: \[
    {Path: \[string\], ErrorResults: \[ErrorRecord\[\]\]}, {Path: \[string\], ErrorResults: \[ErrorRecord\[\]\]}, ...
  \]}

Any errors will also be output to stdout for capture by CI/CD pipelines.

## EXAMPLES

### EXAMPLE 1
```
Pipe path into Confirm-AzBPBicepFile.
```

"./examples/actionGroupErrors.bicep" | Confirm-AzBPBicepFile

Confirm-AzBPBicepFile: ../../../examples/actionGroupErrors.bicep:
Confirm-AzBPBicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(6,7) : Warning no-unused-params: Parameter "location" is declared but never used.
\[https://aka.ms/bicep/linter/no-unused-params\]
Confirm-AzBPBicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(12,13) : Warning no-hardcoded-location: A resource location should not use a hard-coded string or variable value.
Please use a parameter value, an expression, or the string 'global'.
Found: 'westus' \[https://aka.ms/bicep/linter/no-hardcoded-location\]
0

Errors
-----------
{@{Path=../../../examples/actionGroupErrors.bicep; ErrorResults=System.Collections.ObjectModel.Collection\`1\[System.Management.Automation.PSObject\]...

### EXAMPLE 2
```
Pipe multiple paths into Confirm-AzBPBicepFile.
```

"./examples/actionGroupErrors.bicep", "./examples/actionGroupErrors.bicep" | Confirm-AzBPBicepFile

Confirm-AzBPBicepFile: ../../../examples/actionGroupErrors.bicep:
Confirm-AzBPBicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(6,7) : Warning no-unused-params: Parameter "location" is declared but never used.
\[https://aka.ms/bicep/linter/no-unused-params\]
Confirm-AzBPBicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(12,13) : Warning no-hardcoded-location: A resource location should not use a hard-coded string or variable value.
Please use a parameter value, an expression, or the string 'global'.
Found: 'westus' \[https://aka.ms/bicep/linter/no-hardcoded-location\]
0
Confirm-AzBPBicepFile: ../../../examples/actionGroupErrors.bicep:
Confirm-AzBPBicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(6,7) : Warning no-unused-params: Parameter "location" is declared but never used.
\[https://aka.ms/bicep/linter/no-unused-params\]
Confirm-AzBPBicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(12,13) : Warning no-hardcoded-location: A resource location should not use a hard-coded string or variable value.
Please use a parameter value, an expression, or the string 'global'.
Found: 'westus' \[https://aka.ms/bicep/linter/no-hardcoded-location\]
1

Errors
-----------
{@{Path=../../../examples/actionGroupErrors.bicep; ErrorResults=System.Collections.ObjectModel.Collection\`1\[System.Management.Automation.PSObject\]...

### EXAMPLE 3
```
Provide -BicepPath Parameter.
```

Confirm-AzBPBicepFile -BicepPath ./examples/actionGroupErrors.bicep

Confirm-AzBPBicepFile: ../../../examples/actionGroupErrors.bicep:
Confirm-AzBPBicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(6,7) : Warning no-unused-params: Parameter "location" is declared but never used.
\[https://aka.ms/bicep/linter/no-unused-params\]
Confirm-AzBPBicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(12,13) : Warning no-hardcoded-location: A resource location should not use a hard-coded string or variable value.
Please use a parameter value, an expression, or the string 'global'.
Found: 'westus' \[https://aka.ms/bicep/linter/no-hardcoded-location\]
0

Errors
-----------
{@{Path=../../../examples/actionGroupErrors.bicep; ErrorResults=System.Collections.ObjectModel.Collection\`1\[System.Management.Automation.PSObject\]...

### EXAMPLE 4
```
Path without -BicepPath Parameter.
```

Confirm-AzBPBicepFile ./examples/actionGroupErrors.bicep

Confirm-AzBPBicepFile: ../../../examples/actionGroupErrors.bicep:
Confirm-AzBPBicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(6,7) : Warning no-unused-params: Parameter "location" is declared but never used.
\[https://aka.ms/bicep/linter/no-unused-params\]
Confirm-AzBPBicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(12,13) : Warning no-hardcoded-location: A resource location should not use a hard-coded string or variable value.
Please use a parameter value, an expression, or the string 'global'.
Found: 'westus' \[https://aka.ms/bicep/linter/no-hardcoded-location\]
0

Errors
-----------
{@{Path=../../../examples/actionGroupErrors.bicep; ErrorResults=System.Collections.ObjectModel.Collection\`1\[System.Management.Automation.PSObject\]...

## PARAMETERS

### -BicepFilePath
{{ Fill BicepFilePath Description }}

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[]
## OUTPUTS

### System.Management.Automation.PSCustomObject[]
## NOTES

## RELATED LINKS
