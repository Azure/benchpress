namespace Generators.ResourceTypes;

public class StreamAnalyticsJob : ResourceType
{
    public StreamAnalyticsJob() { }

    public override string Id => "Microsoft.StreamAnalytics/streamingjobs";
    public override string FullName => Id;
    public override string FriendlyName => "Stream Analytics Job";
    public override string Prefix => "saj";
    public override string FunctionPrefix => "StreamAnalyticsJob";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "StreamAnalyticsJob"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"])
        };
    }
}
