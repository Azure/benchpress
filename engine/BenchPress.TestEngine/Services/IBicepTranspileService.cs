namespace BenchPress.TestEngine.Services;

public interface IBicepTranspileService
{
    Task<string> BuildAsync(string inputPath);
}
