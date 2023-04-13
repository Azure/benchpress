using Generators.LanguageProviders;
using Microsoft.QualityTools.Testing.Fakes;
using System.IO.Fakes;

namespace Generators.Tests
{
  [TestClass]
  public class TestGeneratorTests
  {
    [TestMethod]
    public void Should_Throw_If_Unknown_TestType()
    {
      using (ShimsContext.Create())
      {
        ShimFile.ReadAllTextString = (string path) =>
        {
          return "template";
        };

        // arrange
        var resourceType = "Microsoft.Insights/actionGroups";
        var resourceName = "Name";
        var extraProperties = new Dictionary<string, string>();

        var metadata = new TestMetadata(resourceType, resourceName, extraProperties);
        var definition = new TestDefinition(metadata, (TestType)Int32.MaxValue);

        var generator = new TestGenerator(new PowershellLanguageProvider());
        var templateFile = "./templates/powershell/template.ps1";

        // act and assert
        Action action = () => { generator.Generate(new List<TestDefinition> { definition }, templateFile); };
        Assert.ThrowsException<Exception>(action);
      }
    }
  }
}
