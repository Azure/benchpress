namespace Generators.ResourceTypes;

public class ApiManagement : ResourceType
{
    public ApiManagement() { }

    public override string Id => "Microsoft.ApiManagement/service";
    public override string FullName => Id;
    public override string FriendlyName => "API Management Service";
    public override string Prefix => "ams";
    public override string FunctionPrefix => "ApiManagement";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "ApiManagement"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"])
        };
    }
}
