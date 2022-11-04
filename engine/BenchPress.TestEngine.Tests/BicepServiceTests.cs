namespace BenchPress.TestEngine.Tests;


public class BicepServiceTests
{
    private readonly BicepService bicepService;
    private readonly ServerCallContext context;

    public BicepServiceTests()
    {
        var logger = new Mock<ILogger<BicepService>>().Object;
        bicepService = new BicepService(logger);
        context = new MockServerCallContext();
    }

    [Fact(Skip = "Not Implemented")]
    public async Task DeploymentGroupCreate_DeploysResourceGroup()
    {
        var request = new DeploymentGroupRequest
        {
            BicepFilePath = "main.bicep",
            ParameterFilePath = "parameters.json",
            ResourceGroupName = "test-rg",
            SubscriptionNameOrId = new Guid().ToString()
        };
        var result = await bicepService.DeploymentGroupCreate(request, context);
        Assert.True(result.Success);
    }

    [Fact(Skip = "Not Implemented")]
    public async Task DeleteGroup_DeletesAllResources()
    {
        var request = new DeleteGroupRequest
        {
            ResourceGroupName = "test-rg",
            SubscriptionNameOrId = new Guid().ToString()
        };
        var result = await bicepService.DeleteGroup(request, context);
        Assert.True(result.Success);
    }
}