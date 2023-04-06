namespace Generators.ResourceTypes;

public class ApiManagementPolicy : ResourceType
{
    public ApiManagementPolicy() { }

    public override string Id => "Microsoft.ApiManagement/service/apis/policies";
    public override string FullName => Id;
    public override string FriendlyName => "API Management Service Policies";
    public override string Prefix => "amspol";
    public override string FunctionPrefix => "ApiManagementPolicy";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "ApiManagementPolicy"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"]),
            Param("ServiceName", m.ExtraProperties["service"]),
            Param("ApiId", m.ExtraProperties["api"])
        };
    }
}
