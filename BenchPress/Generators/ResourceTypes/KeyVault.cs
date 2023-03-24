namespace Generators.ResourceTypes;

public class KeyVault : ResourceType
{
    public KeyVault() { }

    public override string Id => "Microsoft.KeyVault/vaults";

    public override string FullName => Id;

    public override string FriendlyName => "Key Vault";

    public override string Prefix => "kv";

    public override string FunctionPrefix => "KeyVault";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "KeyVault"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"])
        };
    }
}
