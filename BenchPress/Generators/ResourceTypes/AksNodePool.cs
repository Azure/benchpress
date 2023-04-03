namespace Generators.ResourceTypes;

public class AksNodePool : ResourceType
{
    public AksNodePool() { }

    public override string Id => "Microsoft.ContainerService/managedClusters/agentPools";
    public override string FullName => Id;
    public override string FriendlyName => "AKS Node Pool";
    public override string Prefix => "aksnp";
    public override string FunctionPrefix => "AksNodePool";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "AksNodePool"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"]),
            Param("ClusterName", m.ExtraProperties["managedClusters"])
        };
    }
}
