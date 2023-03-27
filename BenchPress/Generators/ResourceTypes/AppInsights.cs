namespace Generators.ResourceTypes;

public class AppInsights : ResourceType
{
    public AppInsights() { }

    public override string Id => "Microsoft.Insights/components";
    public override string FullName => Id;
    public override string FriendlyName => "Application Insights";
    public override string Prefix => "ai";
    public override string FunctionPrefix => "AppInsights";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "AppInsights"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"])
        };
    }
}
