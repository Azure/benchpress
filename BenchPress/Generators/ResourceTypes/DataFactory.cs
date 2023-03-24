namespace Generators.ResourceTypes;

public class DataFactory : ResourceType
{
    public DataFactory() { }

    public override string Id => "Microsoft.DataFactory/factories";

    public override string FullName => Id;

    public override string FriendlyName => "Data Factory";

    public override string Prefix => "adf";

    public override string FunctionPrefix => "DataFactory";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "DataFactory"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"])
        };
    }
}
