namespace Generators.ResourceTypes;

public class ServicePlan : ResourceType
{
  public ServicePlan()
  {
  }

  public const string Id = "Microsoft.Web/serverfarms";

  public override string FullName => Id;

  public override string FriendlyName => "Service Plan";

  public override string Prefix => "svcp";

  public override string FunctionPrefix => "ServicePlan";

  public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
  {
    return new[] {
      Param("name", m.ResourceName),
      Param("resourceGroup", m.ExtraProperties["resourceGroup"])
    };
  }
}
