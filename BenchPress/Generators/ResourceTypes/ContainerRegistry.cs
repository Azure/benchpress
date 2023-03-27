namespace Generators.ResourceTypes;

public class ContainerRegistry : ResourceType
{
    public ContainerRegistry() { }

    public override string Id => "Microsoft.ContainerRegistry/registries";
    public override string FullName => Id;
    public override string FriendlyName => "Container Registry";
    public override string Prefix => "acr";
    public override string FunctionPrefix => "ContainerRegistry";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "ContainerRegistry"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"])
        };
    }
}
