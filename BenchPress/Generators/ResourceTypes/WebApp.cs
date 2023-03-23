namespace Generators.ResourceTypes;

public class WebApp : ResourceType
{
    public WebApp() { }

    public override string Id => "Microsoft.Web/sites";

    public override string FullName => Id;

    public override string FriendlyName => "Web Application";

    public override string Prefix => "app";

    public override string FunctionPrefix => "WebApp";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"])
        };
    }
}
