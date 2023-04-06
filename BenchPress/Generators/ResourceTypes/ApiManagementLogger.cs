namespace Generators.ResourceTypes;

public class ApiManagementLogger : ResourceType
{
    public ApiManagementLogger() { }

    public override string Id => "Microsoft.ApiManagement/service/loggers";
    public override string FullName => Id;
    public override string FriendlyName => "API Management Service Loggers";
    public override string Prefix => "amslog";
    public override string FunctionPrefix => "ApiManagementLogger";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "ApiManagementLogger"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"]),
            Param("ServiceName", m.ExtraProperties["service"])
        };
    }
}
