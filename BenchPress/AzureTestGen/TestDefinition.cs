namespace AzureTestGen;

public class TestDefinition
{
    public TestMetadata Metadata { get; set; }
    public TestType Type { get; set; }
}

public enum TestType
{
    ResourceExists,
    Region,
}