namespace Generators.ResourceTypes;

public class SqlDatabase : ResourceType
{
  public SqlDatabase()
  {
  }

  public override string Id => "Microsoft.Sql/servers/databases";

  public override string FullName => Id;

  public override string FriendlyName => "SQL Database";

  public override string Prefix => "sqldb";

  public override string FunctionPrefix => "SqlDatabase";

  public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
  {
    return new[] {
      Param("name", m.ResourceName),
      Param("resourceGroup", m.ExtraProperties["resourceGroup"])
    };
  }
}
