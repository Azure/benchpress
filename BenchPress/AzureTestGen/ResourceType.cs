namespace AzureTestGen;

public enum ResourceType
{
    ResourceGroup,
    VirtualMachine,
}

public static class ResourceTypeParser {
    internal const string ResourceGroupTypeId = "Microsoft.Resources/resourceGroups";
    internal const string VirtualMachineTypeId = "Microsoft.Compute/virtualMachines";

    public static ResourceType Parse(string resourceType) {
        switch (resourceType) {
            case ResourceGroupTypeId:
                return ResourceType.ResourceGroup;
            case VirtualMachineTypeId:
                return ResourceType.VirtualMachine;
                
            default:
                throw new Exception($"Unknown resource type: {resourceType}");
        }
    }
}

public static class ResourceTypeExtensions
{
    public static string FullName(this ResourceType resourceType)
    {
        switch (resourceType)
        {
            case ResourceType.ResourceGroup:
                return ResourceTypeParser.ResourceGroupTypeId;
            case ResourceType.VirtualMachine:
                return ResourceTypeParser.VirtualMachineTypeId;
                
            default:
                throw new Exception($"Unknown resource type: {resourceType}");
        }
    }
    
    public static string Prefix(this ResourceType resourceType)
    {
        switch (resourceType)
        {
            case ResourceType.ResourceGroup:
                return "rg";
            case ResourceType.VirtualMachine:
                return "vm";
            default:
                throw new Exception($"Unknown resource type: {resourceType}");
        }
    }

    public static string FriendlyName(this ResourceType resourceType)
    {
        switch (resourceType)
        {
            case ResourceType.ResourceGroup:
                return "Resource Group";
            case ResourceType.VirtualMachine:
                return "Virtual Machine";
            default:
                throw new Exception($"Unknown resource type: {resourceType}");
        }
    }

    public static string FunctionPrefix(this ResourceType resourceType)
    {
        switch (resourceType)
        {
            case ResourceType.ResourceGroup:
                return "ResourceGroup";
            case ResourceType.VirtualMachine:
                return "VirtualMachine";
            default:
                throw new Exception($"Unknown resource type: {resourceType}");
        }
    }


}