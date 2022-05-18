namespace Generators.ResourceTypes;

public abstract class ResourceType
{
    internal const string ResourceGroupTypeId = "Microsoft.Resources/resourceGroups";

    public static ResourceType Create(string resourceType)
    {
        switch (resourceType)
        {
            case ResourceGroup.Id:
                return new ResourceGroup();
            case VirtualMachine.Id:
                return new VirtualMachine();

            default:
                throw new UnknownResourceTypeException(resourceType);
        }
    }
    public abstract string FullName { get; }
    public abstract string FriendlyName { get; }
    public abstract string Prefix { get; }
    public abstract string FunctionPrefix { get; }
    public abstract IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m);

    protected static KeyValuePair<string, object> Param(string name, object value)
    {
        return new KeyValuePair<string, object>(name, value);
    }

    public class UnknownResourceTypeException : Exception
    {
        public UnknownResourceTypeException(string resourceType) : base($"Unknown resource type: {resourceType}")
        {
        }
    }
}

