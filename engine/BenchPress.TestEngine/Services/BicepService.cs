namespace BenchPress.TestEngine.Services;

public class BicepService : Bicep.BicepBase
{
    private readonly ILogger<BicepService> logger;

    public BicepService(ILogger<BicepService> logger)
    {
        this.logger = logger;
    }

    public override async Task<DeploymentResult> DeploymentGroupCreate(DeploymentGroupRequest request, ServerCallContext context)
    {
        throw new NotImplementedException();
    }

    public override async Task<DeploymentResult> DeleteGroup(DeleteGroupRequest request, ServerCallContext context)
    {
        throw new NotImplementedException();
    }
}