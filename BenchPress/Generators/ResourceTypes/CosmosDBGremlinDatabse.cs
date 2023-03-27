namespace Generators.ResourceTypes;

public class CosmosDBGremlinDatabse : ResourceType
{
    public CosmosDBGremlinDatabse() { }

    public override string Id => "Microsoft.DocumentDB/databaseAccounts/gremlinDatabases";
    public override string FullName => Id;
    public override string FriendlyName => "CosmosDB Gremlin Database";
    public override string Prefix => "cosmosdbgremlin";
    public override string FunctionPrefix => "CosmosDBGremlinDatabse";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "CosmosDBGremlinDatabse"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"]),
            Param("AccountName", m.ExtraProperties["databaseAccounts"])
        };
    }
}
