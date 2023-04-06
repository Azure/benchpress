namespace Generators.ResourceTypes;

public class KeyVaultSecret : ResourceType
{
    public KeyVaultSecret() { }

    public override string Id => "Microsoft.KeyVault/vaults/secrets";
    public override string FullName => Id;
    public override string FriendlyName => "Key Vault Secret";
    public override string Prefix => "kvs";
    public override string FunctionPrefix => "KeyVaultSecret";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "KeyVaultSecret"),
            Param("ResourceName", m.ResourceName),
            Param("KeyVaultName", m.ExtraProperties["vaults"])
        };
    }
}
