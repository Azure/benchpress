namespace Generators.ResourceTypes;

public class WebAppStaticSite : ResourceType
{
    public WebAppStaticSite() { }

    public override string Id => "Microsoft.Web/staticSites";
    public override string FullName => Id;
    public override string FriendlyName => "Web Application Static Site";
    public override string Prefix => "azbpwass";
    public override string FunctionPrefix => "WebAppStaticSite";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "WebAppStaticSite"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"])
        };
    }
}
