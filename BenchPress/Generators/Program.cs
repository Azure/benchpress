using System.Text.Json;
using System.Text.Json.Nodes;

record TestMetadata(
  string ResourceType,
  string ResourceName,
  List<KeyValuePair<string, object>> ExtraProperties
);

public class Program
{
  public static void Main(string[] args)
  {
    var jsonFileContent = "";

    var inputFileName = args[0];

    if (inputFileName.EndsWith(".bicep"))
    {
      var filename = Path.GetRandomFileName();

      var bicepCliArgs = new string[]
      {
        "build",
        inputFileName,
        "--outfile",
        $"/tmp/{filename}"
      };

      Bicep.Cli.Program.Main(bicepCliArgs).Wait();

      jsonFileContent = File.ReadAllText("/tmp/" + filename);
    }
    else
    {
      jsonFileContent = File.ReadAllText(inputFileName);
    }

    var parsed = JsonNode.Parse(jsonFileContent).AsObject();

    var list = new List<TestMetadata>();

    foreach (var resource in (JsonArray)parsed["resources"])
    {
      var resourceType = resource["type"].ToString().Trim();
      var resourceName = resource["name"].ToString().Trim();

      if (resourceName.StartsWith("[") && resourceName.EndsWith("]"))
      {
        resourceName = resourceName
                          .Replace("[", "")
                          .Replace("]", "")
                          .Replace("parameters", "")
                          .Replace("(", "")
                          .Replace(")", "")
                          .Replace("'", "")
                          .Trim();
        resourceName = parsed["parameters"][resourceName]["defaultValue"].ToString();
      }

      var extraProperties = new List<KeyValuePair<string, object>>();

      list.Add(new TestMetadata(resourceType, resourceName, extraProperties));
    }

    Console.WriteLine(JsonSerializer.Serialize(list));
  }
}
