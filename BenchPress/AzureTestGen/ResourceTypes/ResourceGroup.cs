namespace AzureTestGen.ResourceTypes;

public class ResourceGroup : ResourceType
{
    public ResourceGroup()
    {
    }

    public const string Id = "Microsoft.Resources/resourceGroups";

    public override string FullName => Id;

    public override string FriendlyName => "Resource Groups";

    public override string Prefix => "rg";

    public override string FunctionPrefix => "ResourceGroup";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new [] {
            Param("name", m.ResourceName)
        };
    }
}