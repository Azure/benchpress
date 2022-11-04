namespace BenchPress.TestEngine.Tests;

public class ResourceGroupServiceTests
{
    private readonly ResourceGroupService resourceGroupService;
    private readonly ServerCallContext context;

    public ResourceGroupServiceTests()
    {
        var logger = new Mock<ILogger<ResourceGroupService>>().Object;
        resourceGroupService = new ResourceGroupService(logger);
        context = new MockServerCallContext();
    }

    [Fact(Skip = "Not Implemented")]
    public async Task GetResourceGroup_ResturnsResoureGroup()
    {
        var request = new ResourceGroupRequest
        {
            ResourceGroupName = "test-rg",
            SubscriptionNameOrId = new Guid().ToString()
        };
        var result = await resourceGroupService.GetResourceGroup(request, context);
        Assert.True(result.Existed);
    }
}