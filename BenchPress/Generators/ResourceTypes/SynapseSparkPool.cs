namespace Generators.ResourceTypes;

public class SynapseSparkPool : ResourceType
{
    public SynapseSparkPool() { }

    public override string Id => "Microsoft.Synapse/workspaces/bigDataPools";
    public override string FullName => Id;
    public override string FriendlyName => "Synapse Spark Pool";
    public override string Prefix => "synsprkp";
    public override string FunctionPrefix => "SynapseSparkPool";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "SynapseSparkPool"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"]),
            Param("WorkspaceName", m.ExtraProperties["workspaces"])
        };
    }
}
