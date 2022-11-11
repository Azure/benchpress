namespace BenchPress.TestEngine.Services;

public class ResourceGroupService : ResourceGroup.ResourceGroupBase
{
    private readonly ILogger<ResourceGroupService> logger;

    public ResourceGroupService(ILogger<ResourceGroupService> logger)
    {
        this.logger = logger;
    }

    public override async Task<ResourceGroupResponse> GetResourceGroup(ResourceGroupRequest rg, ServerCallContext context)
    {
        throw new NotImplementedException();
    }
}
