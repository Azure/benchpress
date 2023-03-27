namespace Generators.ResourceTypes;

public class ActionGroup : ResourceType
{
    public ActionGroup() { }

    public override string Id => "Microsoft.Insights/actionGroups";
    public override string FullName => Id;
    public override string FriendlyName => "Action Group";
    public override string Prefix => "ag";
    public override string FunctionPrefix => "ActionGroup";

    public override IEnumerable<KeyValuePair<string, object>> GetResourceParameters(TestMetadata m)
    {
        return new[]
        {
            Param("ResourceType", "ActionGroup"),
            Param("ResourceName", m.ResourceName),
            Param("ResourceGroupName", m.ExtraProperties["resourceGroup"])
        };
    }
}
