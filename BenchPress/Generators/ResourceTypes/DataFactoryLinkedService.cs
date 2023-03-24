namespace Generators.ResourceTypes;

public class DataFactoryLinkedService : ResourceType
{
    public DataFactoryLinkedService() { }

    public override string Id => "Microsoft.DataFactory/factories/linkedServices";

    public override string FullName => Id;

    public override string FriendlyName => "Data Factory Linked Service";

    public override string Prefix => "adfls";

    public override string FunctionPrefix => "DataFactoryLinkedService";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "DataFactoryLinkedService"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"]),
            Param("DataFactoryName", m.ExtraProperties["factories"])
        };
    }
}
