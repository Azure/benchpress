using Generators.ResourceTypes;

namespace Generators.Tests
{
    [TestClass]
    public class ResourceTypeTests
  {
      [TestMethod]
      public void Should_Throw_If_Unknown_ResourceType()
      {
          // arrange
          var resourceType = "Unknown";

          // act and assert
          Action action = () => { ResourceType.Create(resourceType); };
          Assert.ThrowsException<UnknownResourceTypeException>(action);
      }
  }
}
