namespace BenchPress.TestEngine.Services;

public interface IBicepExecute
{
    Task<int> ExecuteCommandAsync(string[] args);
}
