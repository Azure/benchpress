namespace AzureTestGen;

public class SDKFunction
{
    public static SDKFunction Default(TestDefinition definition)
    {
        return new SDKFunction
        {
            Kind = definition.Type,
            ResourceType = definition.Metadata.ResourceType,
        };
    }

    public TestType Kind { get; set; }
    public ResourceType ResourceType { get; set; }
}