using System.Text.Json.Nodes;

namespace Generators;

public class AzureDeploymentImporter
{
  public static IEnumerable<TestMetadata> Import(FileInfo inputFile, string outputFolderPath)
  {
    return Import(inputFile.FullName, outputFolderPath);
  }

  public static IEnumerable<TestMetadata> Import(string inputFileFullPath, string outputFolderPath)
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

      var extraProperties = new Dictionary<string, object>();

      var location = resource["location"]?.ToString()?.Trim();

      // todo: do actual stuff
      if (location == null)
      {
        location = "FAKE-LOCATION";
      }

      extraProperties.Add("location", location);
      extraProperties.Add("resourceGroup", "FAKE-RESOURCE-GROUP");

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
}
