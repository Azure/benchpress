using System.IO;

namespace BenchPress.TestEngine.Services;

public class BicepTranspileService : IBicepTranspileService
{
    private IBicepExecute bicepExecute;
    private IFileService fileService;
    private readonly ILogger<BicepTranspileService> logger;

    public BicepTranspileService(IBicepExecute bicepExecute, ILogger<BicepTranspileService> logger, IFileService fileService)
    {
        this.bicepExecute = bicepExecute;
        this.logger = logger;
        this.fileService = fileService;
    }

    public async Task<string> BuildAsync(string inputPath)
    {
        if (string.IsNullOrWhiteSpace(inputPath))
        {
            throw new ArgumentNullException(nameof(inputPath));
        }

        if(!fileService.FileExists(inputPath))
        {
            throw new FileNotFoundException(nameof(inputPath));
        }

        var extension = fileService.GetFileExtension(inputPath);

        if (extension != ".bicep")
        {
            throw new ArgumentException("Passed file is not a bicep file. File path: " + inputPath);
        }

        inputPath = fileService.GetFileFullPath(inputPath);
        string outputPath = fileService.ChangeFileExtension(inputPath, ".json");

        logger.LogInformation("Invoking Bicep Submodule");
        try
        {
            var result = await bicepExecute.ExecuteCommandAsync(new string[]{
                "build",
                inputPath,
                "--outfile",
                outputPath
            });

            if (result != 0)
            {
                throw new ApplicationException("Bicep transpilation failed");
            }
        }
        catch (Exception ex)
        {
            logger.LogError(ex.Message, ex);
            throw;
        }

        return outputPath;
    }
}
