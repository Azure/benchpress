using System.Text.Json.Nodes;
using System.Text.RegularExpressions;

namespace Generators;

public class AzureDeploymentImporter
{
    private static Regex s_resourceIdParametersRegex = new Regex(
        "\\[resourceId\\((?<resourceIdParameters>.*)\\)\\]",
        RegexOptions.Compiled
    );
    private static string s_resourceIdParametersKey = "resourceIdParameters";
    private static string s_dependsOnKey = "dependsOn";

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

            if (resourceName.StartsWith("[") && resourceName.EndsWith("]"))
            {
                var parts = new[] { "parameters", "variables" };

                foreach (var part in parts)
                {
                    var temp = resourceName;
                    var parsedValue = temp!
                        .Replace("[", "")
                        .Replace("]", "")
                        .Replace(part, "")
                        .Replace("(", "")
                        .Replace(")", "")
                        .Replace("'", "")
                        .Trim();

                    if (!string.IsNullOrWhiteSpace(parsedValue))
                    {
                        var defaultValueNode = parsed[part]?[parsedValue];
                        if (defaultValueNode is JsonObject)
                        {
                            temp = defaultValueNode["defaultValue"]!.ToString();
                        }
                        else
                        {
                            temp = parsed[part]?[parsedValue]?.ToString();
                        }
                    }
                    if (!string.IsNullOrWhiteSpace(temp))
                    {
                        resourceName = temp;
                        break;
                    }
                }
            }

            if (resourceName == null)
            {
                throw new Exception("Failed to parse json file");
            }

            var extraProperties = GetExtraProperties(resource);

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
    private static Dictionary<string, string> GetExtraProperties(JsonNode resource)
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
                        .Groups[s_resourceIdParametersKey]
                        .Captures[0]
                        .Value
                        .Split(
                            ',',
                            StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries
                        );

                    // The number of entries in resourceIdParameters must be 2 or more, otherwise it's not valid.
                    if (resourceIdParameters.Length > 1)
                    {
                        // The first element is the path, so remove the leading/trailing single quotes from
                        // "'Microsft.xxx/yyy/zzz'", then split on the path separator: ["Microsoft.xxx", "yyy", "zzz"],
                        // and finally, remove the leading "Microsoft.xxx" by skipping (1).
                        var pathParts = resourceIdParameters[0].Trim('\'').Split('/').Skip(1).ToList();

                        // There should be one more Resource ID Parameter than path parts, otherwise it is not valid.
                        if (pathParts.Count() == (resourceIdParameters.Count() - 1))
                        {
                            // Skip the path parameter, counts and indexes match now.
                            var values = resourceIdParameters.Skip(1).ToList();

                            for (int index = 0; index < pathParts.Count(); index++)
                            {
                                // If the value is a hard coded value and not a "parameter" or "variable", then the
                                // value will be "'value'" so trim any single quotes (this will not affect "parameter"
                                // or "variable" entries).
                                extraProperties.Add(pathParts[index], values[index].Trim('\''));
                            }
                        }
                    }
                }
            }
        }

        extraProperties.Add("resourceGroup", "FAKE-RESOURCE-GROUP");

        return extraProperties;
    }
}
