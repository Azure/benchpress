namespace Generators.Tests
{
  [TestClass]
  public class TestMetadataTests
  {
    [TestMethod]
    public void Should_Throw_If_Unknown_ResourceType()
    {
      // arrange
      var resourceType = "Unknown";
      var resourceName = "Name";
      var extraProperties = new Dictionary<string, object>();

      // act and assert
      Action action = () => { new TestMetadata(resourceType, resourceName, extraProperties); };
      Assert.ThrowsException<UnknownResourceTypeException>(action);
    }

    [TestMethod]
    public void Should_Succeed_If_ResourceType_Exists()
    {
      // arrange
      var resourceType = "Microsoft.Insights/actionGroups";
      var resourceName = "Name";
      var extraProperties = new Dictionary<string, object>();

      // act
      var metadata = new TestMetadata(resourceType, resourceName, extraProperties);

      // assert
      Assert.IsNotNull(metadata);
    }
  }
}
