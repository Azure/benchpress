namespace Generators.ResourceTypes;

public class SynapseWorkspace : ResourceType
{
    public SynapseWorkspace() { }

    public override string Id => "Microsoft.Synapse/workspaces";
    public override string FullName => Id;
    public override string FriendlyName => "Synapse Workspace";
    public override string Prefix => "synws";
    public override string FunctionPrefix => "SynapseWorkspace";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "SynapseWorkspace"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"])
        };
    }
}
