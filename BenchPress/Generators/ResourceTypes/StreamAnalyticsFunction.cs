namespace Generators.ResourceTypes;

public class StreamAnalyticsFunction : ResourceType
{
    public StreamAnalyticsFunction() { }

    public override string Id => "Microsoft.StreamAnalytics/streamingjobs/functions";
    public override string FullName => Id;
    public override string FriendlyName => "Stream Analytics Function";
    public override string Prefix => "saf";
    public override string FunctionPrefix => "StreamAnalyticsFunction";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "StreamAnalyticsFunction"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"]),
            Param("JobName", m.ExtraProperties["streamingjobs"])
        };
    }
}
