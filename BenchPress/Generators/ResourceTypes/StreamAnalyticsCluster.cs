namespace Generators.ResourceTypes;

public class StreamAnalyticsCluster : ResourceType
{
    public StreamAnalyticsCluster() { }

    public override string Id => "Microsoft.StreamAnalytics/clusters";

    public override string FullName => Id;

    public override string FriendlyName => "Stream Analytics Cluster";

    public override string Prefix => "sac";

    public override string FunctionPrefix => "StreamAnalyticsCluster";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "StreamAnalyticsCluster"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"])
        };
    }
}
