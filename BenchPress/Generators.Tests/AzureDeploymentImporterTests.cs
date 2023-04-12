using Generators.LanguageProviders;

namespace Generators.Tests
{
  [TestClass]
  public class AzureDeploymentImporterTests
  {
    [TestMethod]
    public void Should_Throw_If_Invalid_File_Format()
    {
      var inputFilePath = "in.txt";
      var outputFilePath = "outFolder";
      Action action = () => { AzureDeploymentImporter.Import(inputFilePath, outputFilePath); };
      Assert.ThrowsException<FileFormatException>(action);
    }

    [TestMethod]
    public void Should_Succeed_With_Bicep_File()
    {
      var inputFilePath = "./resourceGroup.bicep";
      var outputFilePath = "outFolder";
      var result = AzureDeploymentImporter.Import(inputFilePath, outputFilePath);

      Assert.IsNotNull(result);
    }
  }
}
