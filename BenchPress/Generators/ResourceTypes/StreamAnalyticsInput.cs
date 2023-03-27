namespace Generators.ResourceTypes;

public class StreamAnalyticsInput : ResourceType
{
    public StreamAnalyticsInput() { }

    public override string Id => "Microsoft.StreamAnalytics/streamingjobs/inputs";
    public override string FullName => Id;
    public override string FriendlyName => "Stream Analytics Input";
    public override string Prefix => "sai";
    public override string FunctionPrefix => "StreamAnalyticsInput";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "StreamAnalyticsInput"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"]),
            Param("JobName", m.ExtraProperties["streamingjobs"])
        };
    }
}
