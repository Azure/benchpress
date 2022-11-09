namespace BenchPress.TestEngine.Tests;

public class BicepTranspileServiceTests
{
    private readonly Mock<IBicepExecute> mockBicepSubmodule;
    private readonly BicepTranspileService bicepTranspileService;

    public BicepTranspileServiceTests()
    {
        mockBicepSubmodule = new Mock<IBicepExecute>();
        var logger = Mock.Of<ILogger<BicepTranspileService>>();
        bicepTranspileService = new BicepTranspileService(mockBicepSubmodule.Object, logger);
    }

    [Theory]
    [InlineData(null)]
    [InlineData("")]
    [InlineData("     ")]
    public async Task Build_NullInputPath_Throws(string inputFile)
    {
        mockBicepSubmodule.Setup(p => p.ExecuteCommandAsync(It.IsAny<string[]>())).ReturnsAsync(0);

        await Assert.ThrowsAsync<ArgumentNullException>(async () => await bicepTranspileService.BuildAsync(inputFile));
        mockBicepSubmodule.Verify(p => p.ExecuteCommandAsync(It.IsAny<string[]>()), Times.Never);
    }

    [Theory]
    [InlineData("a/b/c/test.bicep")]
    public async Task Build_GeneratedArmTemplateExist(string inputFile)
    {
        mockBicepSubmodule.Setup(p => p.ExecuteCommandAsync(It.IsAny<string[]>())).ReturnsAsync(0);
        var inputBicepFilePath = Path.GetFullPath(inputFile);
        var expectedPath = Path.GetFullPath(Path.ChangeExtension(inputBicepFilePath, ".json"));
        var armPath = await bicepTranspileService.BuildAsync(inputBicepFilePath);
        var args = new[] { "build", inputBicepFilePath, "--outfile", expectedPath };

        Assert.Equal(expectedPath, armPath);
        mockBicepSubmodule.Verify(p => p.ExecuteCommandAsync(args), Times.Once);
    }

    [Theory]
    [InlineData("a/b/c/test.txt")]
    public async Task Build_NonBicepFileInputPath_Throws(string inputFile)
    {
        mockBicepSubmodule.Setup(p => p.ExecuteCommandAsync(It.IsAny<string[]>())).ReturnsAsync(0);
        var inputBicepFilePath = Path.GetFullPath(inputFile);

        await Assert.ThrowsAsync<ArgumentException>(async () => await bicepTranspileService.BuildAsync(inputBicepFilePath));
    }

    [Theory]
    [InlineData("a/b/c/test.bicep")]
    public async Task Build_BicepModuleNotImplemented_Throws(string inputFile)
    {
        mockBicepSubmodule.Setup(p => p.ExecuteCommandAsync(It.IsAny<string[]>())).ThrowsAsync(new ApplicationException("Bicep transpilation failed"));
        var inputBicepFilePath = Path.GetFullPath(inputFile);

        await Assert.ThrowsAsync<ApplicationException>(async () => await bicepTranspileService.BuildAsync(inputBicepFilePath));
    }
}
