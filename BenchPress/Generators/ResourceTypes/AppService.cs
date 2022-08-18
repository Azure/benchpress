namespace Generators.ResourceTypes;

public class AppService : ResourceType
{
  public AppService()
  {
  }

  public const string Id = "Microsoft.Web/sites";

  public override string FullName => Id;

  public override string FriendlyName => "App Service";

  public override string Prefix => "app";

  public override string FunctionPrefix => "AppService";

  public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
  {
    return new[] {
      Param("name", m.ResourceName),
      Param("resourceGroup", m.ExtraProperties["resourceGroup"])
    };
  }
}
