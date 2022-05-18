using Generators.ResourceTypes;

namespace Generators;

public class SDKFunction
{
    public SDKFunction(TestDefinition definition)
    {
        Kind = definition.Type;
        ResourceType = definition.Metadata.ResourceType;
    }

    public TestType Kind { get; set; }
    public ResourceType ResourceType { get; set; }
}