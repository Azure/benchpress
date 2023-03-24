namespace Generators.ResourceTypes;

public class EventHubNamespace : ResourceType
{
    public EventHubNamespace() { }

    public override string Id => "Microsoft.EventHub/namespaces";

    public override string FullName => Id;

    public override string FriendlyName => "Event Hub Namespace";

    public override string Prefix => "ehn";

    public override string FunctionPrefix => "EventHubNamespace";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "EventHubNamespace"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"])
        };
    }
}
