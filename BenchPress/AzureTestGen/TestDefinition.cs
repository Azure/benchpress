namespace AzureTestGen;

public class TestDefinition
{
    public TestDefinition(TestMetadata metadata, TestType type)
    {
        Metadata = metadata;
        Type = type;
    }
    
    public TestMetadata Metadata { get; set; }
    public TestType Type { get; set; }
}

public enum TestType
{
    ResourceExists,
    Region,
}