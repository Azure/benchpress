namespace Generators.ResourceTypes;

public class StorageAccount : ResourceType
{
    public StorageAccount() { }

    public override string Id => "Microsoft.Storage/storageAccounts";
    public override string FullName => Id;
    public override string FriendlyName => "Storage Account";
    public override string Prefix => "sa";
    public override string FunctionPrefix => "StorageAccount";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "StorageAccount"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"])
        };
    }
}
