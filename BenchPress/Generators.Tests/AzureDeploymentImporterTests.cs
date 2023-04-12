using Generators.LanguageProviders;

namespace Generators.Tests
{
  [TestClass]
  public class AzureDeploymentImporterTests
  {
    [TestMethod]
    public void Should_Throw_If_Invalid_File_Format()
    {
      // arrange
      var inputFilePath = "in.txt";
      var outputFilePath = "outFolder";

      // act
      Action action = () => { AzureDeploymentImporter.Import(inputFilePath, outputFilePath); };

      // assert
      Assert.ThrowsException<FileFormatException>(action);
    }

    [TestMethod]
    public void Should_Succeed_With_Bicep_File()
    {
      // arrange
      var inputFilePath = "./DeploymentFiles/resourceGroup.bicep";
      var outputFilePath = "outFolder";

      // act
      var result = AzureDeploymentImporter.Import(inputFilePath, outputFilePath);

      // assert
      Assert.IsNotNull(result);
    }

    [TestMethod]
    public void Should_Succeed_With_Json_File()
    {
      // arrange
      var inputFilePath = "./DeploymentFiles/resourceGroup.json";
      var outputFilePath = "outFolder";

      // act
      var result = AzureDeploymentImporter.Import(inputFilePath, outputFilePath);

      // assert
      Assert.IsNotNull(result);
    }

  }
}
