using AzureTestGen.ResourceTypes;

namespace AzureTestGen;

public class TestMetadata
{
    public TestMetadata(string resourceType, string resourceName, IDictionary<string, object> extraProperties)
    {
        ResourceType = ResourceType.Create(resourceType);
        ResourceName = resourceName;
        ExtraProperties = extraProperties;
    }
    public ResourceType ResourceType { get; set; }
    public string ResourceName { get; set; }
    public IDictionary<string, object> ExtraProperties { get; set; }
}
