using System.Text.Json.Nodes;
using System.Text.RegularExpressions;

namespace Generators;

public class AzureDeploymentImporter
{
    private static Regex s_parametersOrVariablesRegex = new Regex(
        @"(?<paramOrVarType>parameters|variables)\('(?<paramOrVarName>.*?)'\)",
        RegexOptions.Compiled
    );
    private static Regex s_resourceIdParametersRegex = new Regex(
        "\\[resourceId\\((?<resourceIdParameters>.*)\\)\\]",
        RegexOptions.Compiled
    );
    private static Regex s_parantheseRegex = new Regex("\\((.*?)\\)", RegexOptions.Compiled);
    private static string s_resourceIdParametersKey = "resourceIdParameters";
    private static string s_dependsOnKey = "dependsOn";
    private static string s_squareBracketPattern = "\\[(.*?)\\]";
    private static string s_squareBracketSubstituition = "$1";
    private static string s_paramOrVarNameGroupKey = "paramOrVarName";
    private static string s_paramOrVarTypeGroupKey = "paramOrVarType";
    private static string s_defaultValueKey = "defaultValue";

    public static IEnumerable<TestMetadata> Import(FileInfo inputFile, string outputFolderPath)
    {
        return Import(inputFile.FullName, outputFolderPath);
    }

    public static IEnumerable<TestMetadata> Import(
        string inputFileFullPath,
        string outputFolderPath
    )
    {
        var jsonFileContent = "";

        if (inputFileFullPath.EndsWith(".bicep"))
        {
            var tempFileFullPath = Path.GetTempFileName();

            var buildArgs = new string[]
            {
                "build",
                inputFileFullPath,
                "--outfile",
                tempFileFullPath
            };

            Bicep.Cli.Program.Main(buildArgs).Wait();

            jsonFileContent = File.ReadAllText(tempFileFullPath);

            var generateParamsArgs = new string[]
            {
                "generate-params",
                inputFileFullPath,
                "--outfile",
                outputFolderPath + "\\generated"
            };

            Bicep.Cli.Program.Main(generateParamsArgs).Wait();

            File.Delete(tempFileFullPath);
        }
        else if (inputFileFullPath.EndsWith(".json"))
        {
            jsonFileContent = File.ReadAllText(inputFileFullPath);
        }
        else
        {
            throw new FileFormatException();
        }

        var parsed = JsonNode.Parse(jsonFileContent)?.AsObject();

        if (parsed == null)
        {
            throw new Exception("Failed to parse json file");
        }

        var list = new List<TestMetadata>();

        foreach (var resource in (JsonArray)parsed["resources"]!)
        {
            if (resource == null)
            {
                throw new Exception("Failed to parse json file");
            }

            var resourceType = resource["type"]?.ToString().Trim();
            var resourceName = resource["name"]?.ToString().Trim();

            if (resourceName == null || resourceType == null)
            {
                throw new Exception("Failed to parse json file");
            }

            resourceName = ResolveParamsAndVariables(resourceName, parsed);

            if (resourceName == null)
            {
                throw new Exception("Failed to parse json file");
            }

            var extraProperties = GetExtraProperties(resource, parsed);

            try
            {
                list.Add(new TestMetadata(resourceType, resourceName, extraProperties));
            }
            catch (UnknownResourceTypeException)
            {
                // ignore
            }
        }
        return list;
    }

    /// <summary>
    /// Sets the extra properties for the test metadata by using information in the resource definition. When
    /// the bicep file is transpiled to an ARM template, the dependsOn property for each resource will be in the form
    /// of a resource unique identifier. The unique identifier can be used to determine any parent or dependent
    /// resources. Any parent or dependent resources will be added to the extra properties dictionary with the resource
    /// type as the key and the resource name as the value. This will allow ResourceTypes that need additional
    /// parameters (i.e. SqlDatabase will need ServerName) to be able to get the value from the extra properties
    /// dictionary.
    /// <example>
    /// For example, the following resource definition:
    /// <code>
    /// {
    ///  "type": "Microsoft.Sql/servers/databases",
    ///  "apiVersion": "2022-05-01-preview",
    ///  "name": "[format('{0}/{1}', parameters('serverName'), parameters('databaseName'))]",
    ///  "location": "[parameters('location')]",
    ///  "sku": {
    ///    "name": "Standard",
    ///    "tier": "Standard"
    ///  },
    ///  "dependsOn": [
    ///    "[resourceId('Microsoft.Sql/servers', parameters('serverName'))]"
    ///  ]
    ///}
    /// </code>
    /// Will result in the following extra properties dictionary:
    /// <code>
    /// {
    ///  "servers": "parameters('serverName')"
    /// }
    /// </code>
    /// </summary>
    private static Dictionary<string, string> GetExtraProperties(
        JsonNode resource,
        JsonObject armTemplateObject
    )
    {
        var extraProperties = new Dictionary<string, string>();
        var dependencies = (JsonArray?)resource[s_dependsOnKey];

        if (dependencies != null)
        {
            foreach (var dependency in dependencies)
            {
                if (dependency != null)
                {
                    // There is only one Capture value for the Group, which is the entire list of parameters that are
                    // passed to "[resourceId()]" as a single string. After the split, the first parameter in
                    // resourceIdParameters will be the path (e.g., "'Microsoft.xxx/yyy/zzz'"), and all further entries
                    // will be values for the path (e.g., "parameters('yyy')", "variables('zzz')").
                    var resourceIdParameters = s_resourceIdParametersRegex
                        .Match(dependency.ToString())
                        .Groups[s_resourceIdParametersKey].Captures[0].Value.Split(
                        ',',
                        StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries
                    );

                    // The number of entries in resourceIdParameters must be 2 or more, otherwise it's not valid.
                    if (resourceIdParameters.Length > 1)
                    {
                        // The first element is the path, so remove the leading/trailing single quotes from
                        // "'Microsft.xxx/yyy/zzz'", then split on the path separator: ["Microsoft.xxx", "yyy", "zzz"],
                        // and finally, remove the leading "Microsoft.xxx" by skipping (1).
                        var pathParts = resourceIdParameters[0]
                            .Trim('\'')
                            .Split('/')
                            .Skip(1)
                            .ToList();

                        // There should be one more Resource ID Parameter than path parts, otherwise it is not valid.
                        if (pathParts.Count() == (resourceIdParameters.Count() - 1))
                        {
                            // Skip the path parameter, counts and indexes match now.
                            var values = resourceIdParameters.Skip(1).ToList();

                            for (int index = 0; index < pathParts.Count(); index++)
                            {
                                // If the value is a "parameter" or "variable", then resolve it to the correct value
                                // of the parameter or variable. If the value is a hard coded value, then the
                                // value will be "'value'" so trim any single quotes.
                                var value = ResolveParamsAndVariables(
                                        values[index],
                                        armTemplateObject
                                    )
                                    .Trim('\'');
                                extraProperties.Add(pathParts[index], value);
                            }
                        }
                    }
                }
            }
        }

        extraProperties.Add("resourceGroup", "FAKE-RESOURCE-GROUP");

        return extraProperties;
    }

    /// <summary>
    /// Takes a string from an ARM template containing instances of <c>parameters('...')</c> and
    /// <c>variables('...')</c> and resolves those instances to the correct values, if possible.
    /// <example>
    /// For example, if the following ARM template (<paramref name="armTemplateObject"/>) with the parameter block
    /// below is passed in:
    /// <code>
    /// {...
    ///   "parameters": {
    ///     "demoParam": {
    ///       "type": "string",
    ///       "defaultValue": "Contoso"
    ///     }
    ///   }
    /// ...}
    /// </code>
    /// and the following string (<paramref name ="stringToResolve"/>) is passed in:
    /// <code>
    /// "[parameters('demoParam')]"
    /// </code>
    /// The parameter will be resolved to the default value and result in the following return value:
    /// <code>
    /// "Contoso"
    /// </code>
    /// This method can also handle resolving ARM template variables. For example if the following ARM template
    /// (<paramref name="armTemplateObject"/>) with the variable block below is passed in:
    /// <code>
    /// {...
    ///   "variables": {
    ///     "demoVar": "Contoso"
    ///   }
    /// ...}
    /// </code>
    /// and the following string (<paramref name ="stringToResolve"/>) is passed in:
    /// <code>
    /// "[variables('demoVar')]"
    /// </code>
    /// The variable will be resolved to the correct value and result in the following return value:
    /// <code>
    /// "Contoso"
    /// </code>
    /// Finally, this method can also handle resolving a mixture of ARM template parameters and variables. For example
    /// if the following ARM template (<paramref name="armTemplateObject"/>) with the parameter and variable block
    /// below is passed in:
    /// <code>
    /// {...
    ///   "parameters": {
    ///     "demoParam": {
    ///       "type": "string",
    ///       "defaultValue": "ContosoParam"
    ///     }
    ///   }
    ///   "variables": {
    ///     "demoVar": "ContosoVar"
    ///   }
    /// ...}
    /// </code>
    /// and the following string (<paramref name ="stringToResolve"/>) is passed in:
    /// <code>
    /// "[format('{0}{1}', variables('demoVar'), parameters('demoParam')]"
    /// </code>
    /// The variable and parameter will be resolved to the correct values and result in the following return value:
    /// <code>
    /// "format('{0}{1}', 'ContosoVar' , 'ContosoParam')"
    /// </code>
    /// </summary>
    private static string ResolveParamsAndVariables(
        string stringToResolve,
        JsonObject armTemplateObject
    )
    {
        // Find and remove square brackets from the parameter/variable string. Square brackets are specific to
        // ARM template syntax and are not needed in generated tests.
        stringToResolve = Regex.Replace(
            stringToResolve,
            s_squareBracketPattern,
            s_squareBracketSubstituition
        );

        // Find all matches in the parameter/variable string that follows the pattern of "parameters('...')" or
        // "variables('...')". The regular expression pattern defines two named subexpressions: paramOrVarType, which
        // represents the type of parameter/variable (e.g., "parameters" or "variables"), and paramOrVarName, which
        // represents the name of the parameter/variable.
        var matches = s_parametersOrVariablesRegex.Matches(stringToResolve);
        foreach (Match match in matches)
        {
            var name = match.Groups[s_paramOrVarNameGroupKey].Value;
            var type = match.Groups[s_paramOrVarTypeGroupKey].Value;
            var resolvedValue = System.String.Empty;

            if (!string.IsNullOrWhiteSpace(name))
            {
                // ARM templates will contain a JSON Object representing parameters and variables for the ARM template.
                // Get the correct JSON Object using the type from the regex match (e.g., "parameters" or "variables").
                var parametersOrVariablesObj = armTemplateObject[type];
                if (parametersOrVariablesObj != null)
                {
                    // Get the value of the parameter/variable from the JSON Object. If the value is still a JSON
                    // Object, that means it is a parameter that has a default value, so get the default value (if it
                    // exists). Otherwise, the value can be converted to a string and assigned to resolveValue.
                    var resolvedValueNode = parametersOrVariablesObj[name];
                    if (resolvedValueNode != null)
                    {
                        if (resolvedValueNode is JsonObject)
                        {
                            resolvedValue = resolvedValueNode[s_defaultValueKey]?.ToString();
                        }
                        else
                        {
                            resolvedValue = resolvedValueNode.ToString();
                        }
                    }
                }
            }
            if (!string.IsNullOrWhiteSpace(resolvedValue))
            {
                // Find and remove square brackets from the resolved value. Square brackets are specific to ARM
                // template syntax and are not needed in generated tests.
                resolvedValue = Regex.Replace(
                    resolvedValue,
                    s_squareBracketPattern,
                    s_squareBracketSubstituition
                );
                // If the resolved value does not contain addtional ARM template functions, then wrap it in single
                // quotes because the resolved value is a plain string type.
                if (!s_parantheseRegex.IsMatch(resolvedValue))
                {
                    resolvedValue = "\'" + resolvedValue + "\'";
                }
                stringToResolve = stringToResolve.Replace(match.Value, resolvedValue);
            }
        }
        return stringToResolve;
    }
}
