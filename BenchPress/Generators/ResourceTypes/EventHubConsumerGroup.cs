namespace Generators.ResourceTypes;

public class EventHubConsumerGroup : ResourceType
{
    public EventHubConsumerGroup() { }

    public override string Id => "Microsoft.EventHub/namespaces/eventhubs/consumerGroups";

    public override string FullName => Id;

    public override string FriendlyName => "Event Hub Consumer Group";

    public override string Prefix => "ehcg";

    public override string FunctionPrefix => "EventHubConsumerGroup";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "EventHubConsumerGroup"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"]),
            Param("NamespaceName", m.ExtraProperties["namespaces"]),
            Param("EventHubName", m.ExtraProperties["eventhubs"])
        };
    }
}
