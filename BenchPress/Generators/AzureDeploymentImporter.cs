using System.Text.Json.Nodes;

namespace Generators;

public class AzureDeploymentImporter
{
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
    /// of a resource unique identifier.  The unique identifier can be used to determine any parent or dependent
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
    private static Dictionary<string, object> GetExtraProperties(JsonNode resource)
    {
        var extraProperties = new Dictionary<string, object>();

        var dependsOn = resource["dependsOn"]?[0]?.ToString().Trim().Split(",");
        var resourceIds = dependsOn?[0].Trim('\'').Split("/").Skip(1).ToArray();
        var resourceNames = dependsOn?.Skip(1).Select(name => name.TrimEnd(')', ']')).ToArray();
        if (
            resourceIds != null
            && resourceNames != null
            && resourceIds.Length == resourceNames.Length
        )
        {
            foreach (var resourceId in resourceIds)
            {
                // When adding resource names to the dictionary, we need to add a closing
                // parenthesis to the end of the resource name because the resource name is initially stripped
                // all ending brackets and parenthesis
                extraProperties.Add(
                    resourceId,
                    resourceNames[Array.IndexOf(resourceIds, resourceId)] + ")"
                );
            }
        }
        extraProperties.Add("resourceGroup", "FAKE-RESOURCE-GROUP");

        return extraProperties;
    }
}
