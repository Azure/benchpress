using System.Text.Json;
using System.Text.Json.Nodes;
using static Generators.ResourceTypes.ResourceType;

namespace Generators;

public class AzureDeploymentImporter
{
  public static IEnumerable<TestMetadata> Import(FileInfo inputFile)
  {
    return Import(inputFile.FullName);
  }

  public static IEnumerable<TestMetadata> Import(string inputFileName)
  {
    var jsonFileContent = "";

    if (inputFileName.EndsWith(".bicep"))
    {
      var filename = Path.GetTempFileName();

      var bicepCliArgs = new string[]
      {
        "build",
        inputFileName,
        "--outfile",
        filename
      };

      Bicep.Cli.Program.Main(bicepCliArgs).Wait();

      jsonFileContent = File.ReadAllText(filename);
      File.Delete(filename);
    }
    else
    {
      jsonFileContent = File.ReadAllText(inputFileName);
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

          if (!String.IsNullOrWhiteSpace(parsedValue))
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
          if (!String.IsNullOrWhiteSpace(temp))
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
