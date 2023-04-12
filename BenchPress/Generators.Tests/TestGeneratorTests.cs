using Generators.LanguageProviders;

namespace Generators.Tests
{
  [TestClass]
  public class TestGeneratorTests
  {
    [TestMethod]
    public void Should_Throw_If_Unknown_TestType()
    {
      var resourceType = "Microsoft.Insights/actionGroups";
      var resourceName = "Name";
      var extraProperties = new Dictionary<string, object>();

      var metadata = new TestMetadata(resourceType, resourceName, extraProperties);
      var definition = new TestDefinition(metadata, (TestType)1);

      var generator = new TestGenerator(new PowershellLanguageProvider());
      var templateFile = "./templates/powershell/template.ps1";

      Action action = () => { generator.Generate(new List<TestDefinition> { definition }, templateFile); };
      Assert.ThrowsException<Exception>(action);
    }
  }
}
