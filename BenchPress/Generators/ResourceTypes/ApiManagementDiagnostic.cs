namespace Generators.ResourceTypes;

public class ApiManagementDiagnostic : ResourceType
{
    public ApiManagementDiagnostic() { }

    public override string Id => "Microsoft.ApiManagement/service/apis";
    public override string FullName => Id;
    public override string FriendlyName => "API Management Service APIs";
    public override string Prefix => "amsdiag";
    public override string FunctionPrefix => "ApiManagementDiagnostic";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "ApiManagementDiagnostic"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"]),
            Param("ServiceName", m.ExtraProperties["serviceName"])
        };
    }
}
