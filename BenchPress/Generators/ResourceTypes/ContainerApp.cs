namespace Generators.ResourceTypes;

public class ContainerApp : ResourceType
{
    public ContainerApp() { }

    public override string Id => "Microsoft.App/containerApps";
    public override string FullName => Id;
    public override string FriendlyName => "Container App";
    public override string Prefix => "conapp";
    public override string FunctionPrefix => "ContainerApp";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "ContainerApp"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"])
        };
    }
}
