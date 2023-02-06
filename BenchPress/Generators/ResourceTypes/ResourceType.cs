using System.Diagnostics.CodeAnalysis;

namespace Generators.ResourceTypes;

#pragma warning disable CS8603
#pragma warning disable CS8602
public abstract class ResourceType
{
    public static ResourceType Create(string resourceTypeString)
    {
        ResourceType? resourceType = AppDomain.CurrentDomain
            .GetAssemblies()
            .SelectMany(assembly => assembly.GetTypes())
            .Where(type => !type.IsAbstract && typeof(ResourceType).IsAssignableFrom(type))
            .Select(type => Activator.CreateInstance(type) as ResourceType)
            .FirstOrDefault(instance => instance is not null && instance.Id == resourceTypeString);

        if (resourceType is null)
        {
            throw new UnknownResourceTypeException(resourceTypeString);
        }

        return resourceType;
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
