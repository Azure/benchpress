namespace Generators.ResourceTypes;

public class AppServicePlan : ResourceType
{
    public AppServicePlan() { }

    public override string Id => "Microsoft.Web/serverfarms";
    public override string FullName => Id;
    public override string FriendlyName => "Application Service Plan";
    public override string Prefix => "asp";
    public override string FunctionPrefix => "AppServicePlan";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "AppServicePlan"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"])
        };
    }
}
