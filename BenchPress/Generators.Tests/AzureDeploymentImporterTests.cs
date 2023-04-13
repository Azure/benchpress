using System.IO.Fakes;
using Bicep.Cli.Fakes;
using Microsoft.QualityTools.Testing.Fakes;

namespace Generators.Tests
{
    [TestClass]
    public class AzureDeploymentImporterTests
    {
      [TestMethod]
      public void Should_Succeed_With_Bicep_File()
      {
        using (ShimsContext.Create())
        {
          ShimProgram.MainStringArray = (string[] input) =>
          {
            return Task.FromResult(0);
          };

          ShimFile.ReadAllTextString = (string input) =>
          {
            return "{\"resources\": [\r\n    {\r\n      \"type\": \"Microsoft.Resources/resourceGroups\",\r\n      \"apiVersion\": \"2022-09-01\",\r\n      \"name\": \"[parameters('name')]\",\r\n      \"location\": \"[parameters('location')]\"\r\n    }\r\n  ]}";
          };

          // arrange
          var inputFilePath = "./DeploymentFiles/resourceGroup.bicep";
          var outputFilePath = "outFolder";

          // act
          var result = AzureDeploymentImporter.Import(inputFilePath, outputFilePath);
          Assert.IsNotNull(result);
        }
      }

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
    }
}
