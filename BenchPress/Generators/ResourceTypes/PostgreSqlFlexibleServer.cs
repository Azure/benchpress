namespace Generators.ResourceTypes;

public class PostgreSqlFlexibleServer : ResourceType
{
    public PostgreSqlFlexibleServer() { }

    public override string Id => "Microsoft.DBforPostgreSQL/flexibleServer";
    public override string FullName => Id;
    public override string FriendlyName => "PostgreSQL Flexible Server";
    public override string Prefix => "psfs";
    public override string FunctionPrefix => "PostgreSqlFlexibleServer";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "PostgreSqlFlexibleServer"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"])
        };
    }
}
