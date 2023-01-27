namespace Generators.ResourceTypes;

public class VirtualMachine : ResourceType
{
    public VirtualMachine() { }

    public override string Id => "Microsoft.Compute/virtualMachines";

    public override string FullName => Id;

    public override string FriendlyName => "Virtual Machines";

    public override string Prefix => "vm";

    public override string FunctionPrefix => "VirtualMachine";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("name", m.ResourceName),
            Param("resourceGroup", m.ExtraProperties["resourceGroup"])
        };
    }
}
