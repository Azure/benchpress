namespace BenchPress.TestEngine.Tests;

public class BicepTranspileServiceTests
{
    private readonly Mock<IBicepExecute> mockBicepSubmodule;
    private readonly Mock<IFileService> mockFileService;
    private readonly BicepTranspileService bicepTranspileService;

    public BicepTranspileServiceTests()
    {
        mockBicepSubmodule = new Mock<IBicepExecute>();
        mockFileService = new Mock<IFileService>();
        var logger = Mock.Of<ILogger<BicepTranspileService>>();
        bicepTranspileService = new BicepTranspileService(mockBicepSubmodule.Object, logger, mockFileService.Object);

        mockBicepSubmodule.Setup(p => p.ExecuteCommandAsync(It.IsAny<string[]>())).ReturnsAsync(0);
        mockFileService.Setup(fs => fs.FileExists(It.IsAny<string>())).Returns(true);
        mockFileService.Setup(fs => fs.GetFileExtension(It.IsAny<string>())).Returns(".bicep");
        mockFileService.Setup(fs => fs.ChangeFileExtension(It.IsAny<string>(),It.IsAny<string>())).Returns("a/b/c/test.json");

    }

    [Theory]
    [InlineData(null)]
    [InlineData("")]
    [InlineData("     ")]
    public async Task Build_NullInputPath_Throws(string inputFile)
    {
        mockFileService.Setup(fs => fs.GetFileFullPath(It.IsAny<string>())).Returns(inputFile);

        await Assert.ThrowsAsync<ArgumentNullException>(async () => await bicepTranspileService.BuildAsync(inputFile));
        mockBicepSubmodule.Verify(p => p.ExecuteCommandAsync(It.IsAny<string[]>()), Times.Never);
    }

    [Theory]
    [InlineData("a/b/c/test.bicep")]
    public async Task Build_GeneratedArmTemplateExist(string inputFile)
    {
        mockFileService.Setup(fs => fs.GetFileFullPath(It.IsAny<string>())).Returns(inputFile);
        var outFile = "a/b/c/test.json";
        var armPath = await bicepTranspileService.BuildAsync(inputFile);
        var args = new[] { "build", inputFile, "--outfile", outFile };

        Assert.Equal(outFile, armPath);
        mockBicepSubmodule.Verify(p => p.ExecuteCommandAsync(args), Times.Once);
    }

    [Theory]
    [InlineData("a/b/c/test.txt")]
    public async Task Build_NonBicepFileInputPath_Throws(string inputFile)
    {
        mockFileService.Setup(fs => fs.GetFileExtension(It.IsAny<string>())).Returns(".txt");
        mockFileService.Setup(fs => fs.GetFileFullPath(It.IsAny<string>())).Returns(inputFile);

        await Assert.ThrowsAsync<ArgumentException>(async () => await bicepTranspileService.BuildAsync(inputFile));
    }

    [Theory]
    [InlineData("a/b/c/test.bicep")]
    public async Task Build_BicepModuleNotImplemented_Throws(string inputFile)
    {
        mockBicepSubmodule.Setup(p => p.ExecuteCommandAsync(It.IsAny<string[]>())).ThrowsAsync(new ApplicationException("Bicep transpilation failed"));
        mockFileService.Setup(fs => fs.GetFileFullPath(It.IsAny<string>())).Returns(inputFile);

        await Assert.ThrowsAsync<ApplicationException>(async () => await bicepTranspileService.BuildAsync(inputFile));
    }

    [Theory]
    [InlineData("a/b/c/test.bicep")]
    public async Task Build_FileNotFoundException_Throws(string inputFile)
    {
        mockFileService.Setup(fs => fs.FileExists(It.IsAny<string>())).Returns(false);

        await Assert.ThrowsAsync<FileNotFoundException>(async () => await bicepTranspileService.BuildAsync(inputFile));
    }
}
