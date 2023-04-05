namespace Generators.ResourceTypes;

public class CosmosDBSqlRoleAssignment : ResourceType
{
    public CosmosDBSqlRoleAssignment() { }

    public override string Id => "Microsoft.DocumentDB/databaseAccounts/sqlRoleAssignments";
    public override string FullName => Id;
    public override string FriendlyName => "CosmosDB Sql Role Assignment";
    public override string Prefix => "cosmosdbsqlra";
    public override string FunctionPrefix => "CosmosDBSqlRoleAssignment";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "CosmosDBSqlRoleAssignment"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"]),
            Param("RoleAssignmentId", m.ExtraProperties["roleAssignments"]),
        };
    }
}
