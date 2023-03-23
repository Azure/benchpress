namespace Generators.ResourceTypes;

public class SqlServer : ResourceType
{
    public SqlServer() { }

    public override string Id => "Microsoft.Sql/servers";

    public override string FullName => Id;

    public override string FriendlyName => "SQL Server";

    public override string Prefix => "sqlserver";

    public override string FunctionPrefix => "SqlServer";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"])
        };
    }
}
