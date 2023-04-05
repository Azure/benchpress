namespace Generators.ResourceTypes;

public class ApiManagementApi : ResourceType
{
    public ApiManagementApi() { }

    public override string Id => "Microsoft.ApiManagement/service/apis";
    public override string FullName => Id;
    public override string FriendlyName => "API Management Service APIs";
    public override string Prefix => "amsapi";
    public override string FunctionPrefix => "ApiManagementApi";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "ApiManagementApi"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"]),
            Param("ServiceName", m.ExtraProperties["serviceName"])
        };
    }
}
