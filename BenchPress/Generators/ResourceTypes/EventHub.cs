namespace Generators.ResourceTypes;

public class EventHub : ResourceType
{
    public EventHub() { }

    public override string Id => "Microsoft.EventHub/namespaces/eventhubs";

    public override string FullName => Id;

    public override string FriendlyName => "Event Hub";

    public override string Prefix => "eh";

    public override string FunctionPrefix => "EventHub";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "EventHub"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"]),
            Param("NamespaceName", m.ExtraProperties["namespaces"])
        };
    }
}
