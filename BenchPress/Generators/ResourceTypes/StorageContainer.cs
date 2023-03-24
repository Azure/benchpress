namespace Generators.ResourceTypes
{
    public class StorageContainer : ResourceType
    {
        public StorageContainer() { }

        public override string Id => "Microsoft.Storage/storageAccounts/blobServices/containers";

        public override string FullName => Id;

        public override string FriendlyName => "Storage Container";

        public override string Prefix => "sa";

        public override string FunctionPrefix => "StorageContainer";

        public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
        {
            return new[]
            {
                Param("ResourceType", "StorageContainer"),
                Param("ResourceName", m.ResourceName),
                Param("ResourceGroupName", m.ExtraProperties["resourceGroup"]),
                Param("AccountName", m.ExtraProperties["storageAccounts"])
            };
        }
    }
}
