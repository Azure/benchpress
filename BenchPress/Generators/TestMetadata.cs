using Generators.ResourceTypes;

namespace Generators;

public class TestMetadata
{
    public TestMetadata(
        string resourceType,
        string resourceName,
        IDictionary<string, string> extraProperties
    )
    {
        ResourceType = ResourceType.Create(resourceType);
        ResourceName = resourceName;
        ExtraProperties = extraProperties;
    }

    public ResourceType ResourceType { get; set; }
    public string ResourceName { get; set; }
    public IDictionary<string, string> ExtraProperties { get; set; }
}

public class UnknownResourceTypeException : Exception
{
    public UnknownResourceTypeException(string resourceType)
        : base($"Unknown resource type: {resourceType}") { }
}
