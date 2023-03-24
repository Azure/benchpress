namespace Generators.ResourceTypes;

public class CosmosDBAccount : ResourceType
{
    public CosmosDBAccount() { }

    public override string Id => "Microsoft.DocumentDB/databaseAccounts";

    public override string FullName => Id;

    public override string FriendlyName => "CosmosDB Account";

    public override string Prefix => "cosmos";

    public override string FunctionPrefix => "CosmosDBAccount";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "CosmosDBAccount"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"])
        };
    }
}
