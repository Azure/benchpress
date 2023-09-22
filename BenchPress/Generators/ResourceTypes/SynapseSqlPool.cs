namespace Generators.ResourceTypes;

public class SynapseSqlPool : ResourceType
{
    public SynapseSqlPool() { }

    public override string Id => "Microsoft.Synapse/workspaces/sqlPools";
    public override string FullName => Id;
    public override string FriendlyName => "Synapse Sql Pool";
    public override string Prefix => "synsqlp";
    public override string FunctionPrefix => "SynapseSqlPool";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "SynapseSqlPool"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"]),
            Param("WorkspaceName", m.ExtraProperties["workspaces"])
        };
    }
}
