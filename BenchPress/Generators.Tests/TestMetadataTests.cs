namespace Generators.Tests
{
  [TestClass]
  public class TestMetadataTests
  {
    [TestMethod]
    public void Should_Throw_If_Unknown_ResourceType()
    {
      var resourceType = "Unknown";
      var resourceName = "Name";
      var extraProperties = new Dictionary<string, object>();

      Action action = () => { new TestMetadata(resourceType, resourceName, extraProperties); };
      Assert.ThrowsException<UnknownResourceTypeException>(action);
    }

    [TestMethod]
    public void Should_Succeed_If_ResourceType_Exists()
    {
      var resourceType = "Microsoft.Insights/actionGroups";
      var resourceName = "Name";
      var extraProperties = new Dictionary<string, object>();

      var metadata = new TestMetadata(resourceType, resourceName, extraProperties);

      Assert.IsNotNull(metadata);
    }
  }
}
