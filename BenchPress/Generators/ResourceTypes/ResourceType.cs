using System.Diagnostics.CodeAnalysis;

namespace Generators.ResourceTypes;

public abstract class ResourceType
{
    public static ResourceType? Create(string resourceType)
    {
        return AppDomain.CurrentDomain
            .GetAssemblies()
            .SelectMany(assembly => assembly.GetTypes())
            .Where(type => !type.IsAbstract && typeof(ResourceType).IsAssignableFrom(type))
            .Select(type => Activator.CreateInstance(type) as ResourceType)
            .FirstOrDefault(instance => instance is not null && instance.Id == resourceType);
    }

    public abstract string Id { get; }
    public abstract string FullName { get; }
    public abstract string FriendlyName { get; }
    public abstract string Prefix { get; }
    public abstract string FunctionPrefix { get; }
    public abstract IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m);

    protected static KeyValuePair<string, object> Param(string name, object value)
    {
        return new KeyValuePair<string, object>(name, value);
    }
}
