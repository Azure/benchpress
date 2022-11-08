using Azure.ResourceManager;
using Azure.ResourceManager.Resources;

namespace BenchPress.TestEngine.Tests;

public class BicepServiceTests
{
    private readonly BicepService bicepService;
    private readonly ServerCallContext context;
    private readonly Mock<IArmDeploymentService> armDeploymentMock;

    public BicepServiceTests()
    {
        var logger = Mock.Of<ILogger<BicepService>>();
        armDeploymentMock = new Mock<IArmDeploymentService>(MockBehavior.Strict);
        bicepService = new BicepService(logger, armDeploymentMock.Object);
        context = new MockServerCallContext();
    }

    [Fact]
    public async Task DeploymentGroupCreate_DeploysResourceGroup_WithTranspiledFiles()
    {
        // TODO: set up successful transpilation
        var templatePath = validGroupRequest.BicepFilePath;
        SetUpSuccessfulGroupDeployment(validGroupRequest, templatePath);
        var result = await bicepService.DeploymentGroupCreate(validGroupRequest, context);
        Assert.True(result.Success);
        VerifyGroupDeployment(validGroupRequest, templatePath);
    }

    [Theory]
    [InlineData("main.bicep", "", "a3a01f37-665c-4ee8-9bc3-3adf7ebcec0d")]
    [InlineData("", "rg-test", "a3a01f37-665c-4ee8-9bc3-3adf7ebcec0d")]
    [InlineData("main.bicep", "rg-test", "")]
    public async Task DeploymentGroupCreate_FailsOnMissingParameters(string bicepFilePath, string resourceGroupName, string subscriptionNameOrId)
    {
        var request = SetUpGroupRequest(bicepFilePath, resourceGroupName, subscriptionNameOrId);
        // TODO: set up successful transpilation
        var templatePath = request.BicepFilePath;
        SetUpSuccessfulGroupDeployment(request, templatePath);
        var result = await bicepService.DeploymentGroupCreate(request, context);
        Assert.False(result.Success);
        // TODO: verify transpile wasn't called
        VerifyNoDeployments();
    }

    [Fact(Skip = "Not Fully Implemented")]
    public async Task DeploymentGroupCreate_ReturnsFailureOnTranspileException()
    {
        var expectedMessage = "the bicep file was malformed";
        // TODO: set up exception throwing transpilation
        SetUpSuccessfulGroupDeployment(validGroupRequest, "template.json");
        var result = await bicepService.DeploymentGroupCreate(validGroupRequest, context);
        Assert.False(result.Success);
        Assert.Equal(expectedMessage, result.ErrorMessage);
    }

    [Fact]
    public async Task DeploymentGroupCreate_ReturnsFailureOnFailedDeployment()
    {
        // TODO: set up successful transpilation
        var expectedReason = "Failure occured during deployment";
        SetUpFailedGroupDeployment(expectedReason);
        var result = await bicepService.DeploymentGroupCreate(validGroupRequest, context);
        Assert.False(result.Success);
        Assert.Equal(expectedReason, result.ErrorMessage);
    }

    [Fact]
    public async Task DeploymentGroupCreate_ReturnsFailureOnDeploymentException()
    {
        // TODO: set up successful transpilation
        var expectedMessage = "the template was malformed";
        SetUpExceptionThrowingGroupDeployment(new Exception(expectedMessage));
        var result = await bicepService.DeploymentGroupCreate(validGroupRequest, context);
        Assert.False(result.Success);
        Assert.Equal(expectedMessage, result.ErrorMessage);
    }

    [Fact(Skip = "Not Implemented")]
    public async Task DeleteGroup_DeletesAllResources()
    {
        var request = new DeleteGroupRequest
        {
            ResourceGroupName = "test-rg",
            SubscriptionNameOrId = Guid.NewGuid().ToString()
        };
        var result = await bicepService.DeleteGroup(request, context);
        Assert.True(result.Success);
    }

    private readonly DeploymentGroupRequest validGroupRequest = new DeploymentGroupRequest
    {
        BicepFilePath = "main.bicep",
        ResourceGroupName = "test-rg",
        SubscriptionNameOrId = Guid.NewGuid().ToString()
    };

    private DeploymentGroupRequest SetUpGroupRequest(string bicepFilePath, string resourceGroupName, string subscriptionNameOrId) {
        return new DeploymentGroupRequest
        {
            BicepFilePath = bicepFilePath,
            ResourceGroupName = resourceGroupName,
            SubscriptionNameOrId = subscriptionNameOrId
        };
    }

    private ArmOperation<ArmDeploymentResource> SetupDeploymentOperation(bool success, string reason) {
        var responseMock = new Mock<Azure.Response>();
        responseMock.Setup(x => x.IsError).Returns(!success);
        responseMock.Setup(x => x.ReasonPhrase).Returns(reason);
        var operationMock = new Mock<ArmOperation<ArmDeploymentResource>>();
        operationMock.Setup(x => x.WaitForCompletionResponse(default)).Returns(responseMock.Object);
        return operationMock.Object;
    }

    private void SetUpSuccessfulGroupDeployment(DeploymentGroupRequest request, string templatePath) {
        var operation = SetupDeploymentOperation(true, "OK");
        armDeploymentMock.Setup(x => x.DeployArmToResourceGroupAsync(
                request.SubscriptionNameOrId,
                request.ResourceGroupName,
                templatePath,
                request.ParameterFilePath,
                It.IsAny<Azure.WaitUntil>()))
            .ReturnsAsync(operation);
    }

    private void SetUpFailedGroupDeployment(string reason) {
        var operation = SetupDeploymentOperation(false, reason);
        armDeploymentMock.Setup(x => x.DeployArmToResourceGroupAsync(
                It.IsAny<string>(),
                It.IsAny<string>(),
                It.IsAny<string>(),
                It.IsAny<string>(),
                It.IsAny<Azure.WaitUntil>()))
            .ReturnsAsync(operation);
    }

    private void SetUpExceptionThrowingGroupDeployment(Exception ex) {
        armDeploymentMock.Setup(x => x.DeployArmToResourceGroupAsync(
                It.IsAny<string>(),
                It.IsAny<string>(),
                It.IsAny<string>(),
                It.IsAny<string>(),
                It.IsAny<Azure.WaitUntil>()))
            .ThrowsAsync(ex);  
    }

    private void VerifyGroupDeployment(DeploymentGroupRequest request, string templatePath) {
        armDeploymentMock.Verify(x => x.DeployArmToResourceGroupAsync(
                request.SubscriptionNameOrId,
                request.ResourceGroupName,
                templatePath,
                request.ParameterFilePath,
                It.IsAny<Azure.WaitUntil>()),
            Times.Once);
    }

    private void VerifyNoDeployments() {
        armDeploymentMock.Verify(x => x.DeployArmToResourceGroupAsync(
                It.IsAny<string>(),
                It.IsAny<string>(),
                It.IsAny<string>(),
                It.IsAny<string>(),
                It.IsAny<Azure.WaitUntil>()),
            Times.Never);
    }
}