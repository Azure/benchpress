namespace Generators.ResourceTypes;

public class ApiManagementPolicy : ResourceType
{
    public ApiManagementPolicy() { }

    public override string Id => "Microsoft.ApiManagement/service/apis";
    public override string FullName => Id;
    public override string FriendlyName => "API Management Service APIs";
    public override string Prefix => "amspol";
    public override string FunctionPrefix => "ApiManagementPolicy";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "ApiManagementPolicy"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"]),
            Param("ServiceName", m.ExtraProperties["serviceName"]),
            Param("ApiId", m.ExtraProperties["apiName"])
        };
    }
}
