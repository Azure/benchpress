namespace Generators.ResourceTypes;

public class KeyVaultKey : ResourceType
{
    public KeyVaultKey() { }

    public override string Id => "Microsoft.KeyVault/vaults/keys";
    public override string FullName => Id;
    public override string FriendlyName => "Key Vault Key";
    public override string Prefix => "kvk";
    public override string FunctionPrefix => "KeyVaultKey";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "KeyVaultKey"),
            Param("ResourceName", m.ResourceName),
            Param("KeyVaultName", m.ExtraProperties["vaults"])
        };
    }
}
