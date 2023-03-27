namespace Generators.ResourceTypes;

public class CosmosDBSqlDatabase : ResourceType
{
    public CosmosDBSqlDatabase() { }

    public override string Id => "Microsoft.DocumentDB/databaseAccounts/sqlDatabases";
    public override string FullName => Id;
    public override string FriendlyName => "CosmosDBSql";
    public override string Prefix => "cosmosdbsql";
    public override string FunctionPrefix => "CosmosDBSql";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "CosmosDBSqlDatabase"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"]),
            Param("AccountName", m.ExtraProperties["databaseAccounts"])
        };
    }
}
