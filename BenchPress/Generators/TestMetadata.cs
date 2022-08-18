using Generators.ResourceTypes;

namespace Generators;

public class TestMetadata
{
  public TestMetadata(string resourceType, string resourceName, IDictionary<string, object> extraProperties)
  {
    ResourceType = ResourceType.Create(resourceType);
    ResourceName = resourceName;
    ExtraProperties = extraProperties;

    if (ResourceType is null)
    {
      throw new UnknownResourceTypeException(resourceType);
    }
  }
  public ResourceType ResourceType { get; set; }
  public string ResourceName { get; set; }
  public IDictionary<string, object> ExtraProperties { get; set; }
}

public class UnknownResourceTypeException : Exception
{
  public UnknownResourceTypeException(string resourceType) : base($"Unknown resource type: {resourceType}")
  {
  }
}
