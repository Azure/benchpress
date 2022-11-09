using Bicep.Cli;

namespace BenchPress.TestEngine.Services;

public class BicepExecute : IBicepExecute
{
    public Task<int> ExecuteCommandAsync(string[] args)
    {
        return Bicep.Cli.Program.Main(args);
    }
}
