namespace Generators.ResourceTypes;

public class CosmosDBSqlRoleDefinition : ResourceType
{
    public CosmosDBSqlRoleDefinition() { }

    public override string Id => "Microsoft.DocumentDB/databaseAccounts/sqlRoleDefinitions";
    public override string FullName => Id;
    public override string FriendlyName => "CosmosDB Sql Role Definition";
    public override string Prefix => "cosmosdbsqlrd";
    public override string FunctionPrefix => "CosmosDBSqlRoleDefinition";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "CosmosDBSqlRoleDefinition"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"]),
            Param("RoleDefinitionId", m.ExtraProperties["roleDefinitions"]),
        };
    }
}
