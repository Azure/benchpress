namespace Generators.ResourceTypes;

public class StreamAnalyticsOutput : ResourceType
{
    public StreamAnalyticsOutput() { }

    public override string Id => "Microsoft.StreamAnalytics/streamingjobs/outputs";

    public override string FullName => Id;

    public override string FriendlyName => "Stream Analytics Output";

    public override string Prefix => "sao";

    public override string FunctionPrefix => "StreamAnalyticsOutput";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "StreamAnalyticsOutput"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"]),
            Param("JobName", m.ExtraProperties["streamingjobs"])
        };
    }
}
