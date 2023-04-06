namespace Generators.ResourceTypes;

public class PortalDashboard : ResourceType
{
    public PortalDashboard() { }

    public override string Id => "Microsoft.Portal/dashboards";
    public override string FullName => Id;
    public override string FriendlyName => "Portal Dashboard";
    public override string Prefix => "pd";
    public override string FunctionPrefix => "PortalDashboard";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "PortalDashboard"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"])
        };
    }
}
