namespace Generators.ResourceTypes;

public class CosmosDBMongoDBDatabase : ResourceType
{
    public CosmosDBMongoDBDatabase() { }

    public override string Id => "Microsoft.DocumentDB/databaseAccounts/mongodbDatabases";
    public override string FullName => Id;
    public override string FriendlyName => "CosmosDB Mongo";
    public override string Prefix => "cosmosdbmongo";
    public override string FunctionPrefix => "CosmosDBMongo";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "CosmosDBMongoDBDatabase"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"]),
            Param("AccountName", m.ExtraProperties["databaseAccounts"])
        };
    }
}
