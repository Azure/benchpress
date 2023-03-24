namespace Generators.ResourceTypes;

public class AksCluster : ResourceType
{
  public AksCluster() { }
  public override string Id => "Microsoft.ContainerService/managedClusters";
  public override string FullName => Id;
  public override string FriendlyName => "AKS Cluster";
  public override string Prefix => "aks";
  public override string FunctionPrefix => "AksCluster";
  public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
  {
    return new[]
    {
      Param("ResourceType", "AksCluster"),
      Param("ResourceName", m.ResourceName),
      Param("ResourceGroupName", m.ExtraProperties["resourceGroup"])
    };
  }
}
