namespace Generators.ResourceTypes;

public class ContainerAppManagedEnv : ResourceType
{
    public ContainerAppManagedEnv() { }

    public override string Id => "Microsoft.App/managedEnvironments";
    public override string FullName => Id;
    public override string FriendlyName => "Container App Managed Environments";
    public override string Prefix => "came";
    public override string FunctionPrefix => "ContainerAppManagedEnv";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "ContainerAppManagedEnv"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"])
        };
    }
}
