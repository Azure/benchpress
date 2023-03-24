namespace Generators.ResourceTypes;

public class OperationalInsightsWorkspace : ResourceType
{
    public OperationalInsightsWorkspace() { }

    public override string Id => "Microsoft.OperationalInsights/workspaces";
    public override string FullName => Id;
    public override string FriendlyName => "Operational Insights Workspace";
    public override string Prefix => "oiw";
    public override string FunctionPrefix => "OperationalInsightsWorkspace";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "OperationalInsightsWorkspace"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"])
        };
    }
}
