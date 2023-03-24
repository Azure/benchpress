namespace Generators.ResourceTypes;

public class StreamAnalyticsTransformation : ResourceType
{
    public StreamAnalyticsTransformation() { }

    public override string Id => "Microsoft.StreamAnalytics/streamingjobs/transformations";
    public override string FullName => Id;
    public override string FriendlyName => "Stream Analytics Transformation";
    public override string Prefix => "sat";
    public override string FunctionPrefix => "StreamAnalyticsTransformation";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "StreamAnalyticsTransformation"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"]),
            Param("JobName", m.ExtraProperties["streamingjobs"])
        };
    }
}
