using Azure.ResourceManager;
using Azure.ResourceManager.Resources;

namespace BenchPress.TestEngine.Tests;

public class DeploymentServiceTests
{
    private readonly DeploymentService deploymentService;
    private readonly ServerCallContext context;
    private readonly Mock<IBicepTranspileService> bicepTranspileServiceMock;
    private readonly Mock<IArmDeploymentService> armDeploymentMock;
    private const string templatePath = "main.json";

    public DeploymentServiceTests()
    {
        var logger = Mock.Of<ILogger<DeploymentService>>();
        bicepTranspileServiceMock = new Mock<IBicepTranspileService>(MockBehavior.Strict);
        armDeploymentMock = new Mock<IArmDeploymentService>(MockBehavior.Strict);
        deploymentService = new DeploymentService(logger, bicepTranspileServiceMock.Object, armDeploymentMock.Object);
        context = new MockServerCallContext();
    }

    [Fact]
    public async Task DeploymentGroupCreate_DeploysResourceGroup_WithTranspiledFiles()
    {
        SetUpSuccessfulTranspilation(validGroupRequest.BicepFilePath, templatePath);
        SetUpSuccessfulGroupDeployment(validGroupRequest, templatePath);
        var result = await deploymentService.DeploymentGroupCreate(validGroupRequest, context);
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
        SetUpSuccessfulTranspilation(validGroupRequest.BicepFilePath, templatePath);
        SetUpSuccessfulGroupDeployment(request, templatePath);
        var result = await deploymentService.DeploymentGroupCreate(request, context);
        Assert.False(result.Success);
        VerifyNoTranspilation();
        VerifyNoDeployments();
    }

    [Fact]
    public async Task DeploymentGroupCreate_ReturnsFailureOnTranspileException()
    {
        var expectedMessage = "the bicep file was malformed";
        SetUpExceptionThrowingTranspilation(new Exception(expectedMessage));
        SetUpSuccessfulGroupDeployment(validGroupRequest, "template.json");
        var result = await deploymentService.DeploymentGroupCreate(validGroupRequest, context);
        Assert.False(result.Success);
        Assert.Equal(expectedMessage, result.ErrorMessage);
    }

    [Fact]
    public async Task DeploymentGroupCreate_ReturnsFailureOnFailedDeployment()
    {
        SetUpSuccessfulTranspilation(validGroupRequest.BicepFilePath, templatePath);
        var expectedReason = "Failure occured during deployment";
        SetUpFailedGroupDeployment(expectedReason);
        var result = await deploymentService.DeploymentGroupCreate(validGroupRequest, context);
        Assert.False(result.Success);
        Assert.Equal(expectedReason, result.ErrorMessage);
    }

    [Fact]
    public async Task DeploymentGroupCreate_ReturnsFailureOnDeploymentException()
    {
        SetUpSuccessfulTranspilation(validGroupRequest.BicepFilePath, templatePath);
        var expectedMessage = "the template was malformed";
        SetUpExceptionThrowingGroupDeployment(new Exception(expectedMessage));
        var result = await deploymentService.DeploymentGroupCreate(validGroupRequest, context);
        Assert.False(result.Success);
        Assert.Equal(expectedMessage, result.ErrorMessage);
    }

    [Fact]
    public async Task DeploymentSubCreate_DeploysToSub_WithTranspiledFiles()
    {
        SetUpSuccessfulTranspilation(validSubRequest.BicepFilePath, templatePath);
        SetUpSuccessfulSubDeployment(validSubRequest, templatePath);
        var result = await deploymentService.DeploymentSubCreate(validSubRequest, context);
        Assert.True(result.Success);
        VerifySubDeployment(validSubRequest, templatePath);
    }

    [Theory]
    [InlineData("main.bicep", "", "a3a01f37-665c-4ee8-9bc3-3adf7ebcec0d")]
    [InlineData("", "eastus", "a3a01f37-665c-4ee8-9bc3-3adf7ebcec0d")]
    [InlineData("main.bicep", "eastus", "")]
    public async Task DeploymentSubCreate_FailsOnMissingParameters(string bicepFilePath, string location, string subscriptionNameOrId)
    {
        var request = SetUpSubRequest(bicepFilePath, location, subscriptionNameOrId);
        SetUpSuccessfulTranspilation(validSubRequest.BicepFilePath, templatePath);
        SetUpSuccessfulSubDeployment(request, templatePath);
        var result = await deploymentService.DeploymentSubCreate(request, context);
        Assert.False(result.Success);
        VerifyNoTranspilation();
        VerifyNoDeployments();
    }

    [Fact]
    public async Task DeploymentSubCreate_ReturnsFailureOnTranspileException()
    {
        var expectedMessage = "the bicep file was malformed";
        SetUpExceptionThrowingTranspilation(new Exception(expectedMessage));
        SetUpSuccessfulSubDeployment(validSubRequest, "template.json");
        var result = await deploymentService.DeploymentSubCreate(validSubRequest, context);
        Assert.False(result.Success);
        Assert.Equal(expectedMessage, result.ErrorMessage);
    }

    [Fact]
    public async Task DeploymentSubCreate_ReturnsFailureOnFailedDeployment()
    {
        SetUpSuccessfulTranspilation(validSubRequest.BicepFilePath, templatePath);
        var expectedReason = "Failure occured during deployment";
        SetUpFailedSubDeployment(expectedReason);
        var result = await deploymentService.DeploymentSubCreate(validSubRequest, context);
        Assert.False(result.Success);
        Assert.Equal(expectedReason, result.ErrorMessage);
    }

    [Fact]
    public async Task DeploymentSubpCreate_ReturnsFailureOnDeploymentException()
    {
        SetUpSuccessfulTranspilation(validSubRequest.BicepFilePath, templatePath);
        var expectedMessage = "the template was malformed";
        SetUpExceptionThrowingSubDeployment(new Exception(expectedMessage));
        var result = await deploymentService.DeploymentSubCreate(validSubRequest, context);
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
        var result = await deploymentService.DeleteGroup(request, context);
        Assert.True(result.Success);
    }

    private readonly DeploymentGroupRequest validGroupRequest = new DeploymentGroupRequest
    {
        BicepFilePath = "main.bicep",
        ResourceGroupName = "test-rg",
        SubscriptionNameOrId = Guid.NewGuid().ToString()
    };

    private readonly DeploymentSubRequest validSubRequest = new DeploymentSubRequest
    {
        BicepFilePath = "main.bicep",
        Location = "eastus",
        SubscriptionNameOrId = Guid.NewGuid().ToString()
    };

    private DeploymentGroupRequest SetUpGroupRequest(string bicepFilePath, string resourceGroupName, string subscriptionNameOrId)
    {
        return new DeploymentGroupRequest
        {
            BicepFilePath = bicepFilePath,
            ResourceGroupName = resourceGroupName,
            SubscriptionNameOrId = subscriptionNameOrId
        };
    }

    private DeploymentSubRequest SetUpSubRequest(string bicepFilePath, string location, string subscriptionNameOrId)
    {
        return new DeploymentSubRequest
        {
            BicepFilePath = bicepFilePath,
            Location = location,
            SubscriptionNameOrId = subscriptionNameOrId
        };
    }

    private void SetUpSuccessfulTranspilation(string bicepFilePath, string armTemplatePath)
    {
        bicepTranspileServiceMock.Setup(x => x.BuildAsync(bicepFilePath)).ReturnsAsync(armTemplatePath);
    }

    private void SetUpExceptionThrowingTranspilation(Exception ex)
    {
        bicepTranspileServiceMock.Setup(x => x.BuildAsync(It.IsAny<string>())).ThrowsAsync(ex);
    }

    private void VerifyTranspilation(string bicepFilePath)
    {
        bicepTranspileServiceMock.Verify(x => x.BuildAsync(bicepFilePath), Times.Once);
    }

    private void VerifyNoTranspilation()
    {
        bicepTranspileServiceMock.Verify(x => x.BuildAsync(It.IsAny<string>()), Times.Never);
    }

    private ArmOperation<ArmDeploymentResource> SetupDeploymentOperation(bool success, string reason)
    {
        var responseMock = new Mock<Azure.Response>();
        responseMock.Setup(x => x.IsError).Returns(!success);
        responseMock.Setup(x => x.ReasonPhrase).Returns(reason);
        var operationMock = new Mock<ArmOperation<ArmDeploymentResource>>();
        operationMock.Setup(x => x.WaitForCompletionResponse(default)).Returns(responseMock.Object);
        return operationMock.Object;
    }

    private void SetUpSuccessfulGroupDeployment(DeploymentGroupRequest request, string templatePath)
    {
        var operation = SetupDeploymentOperation(true, "OK");
        armDeploymentMock.Setup(x => x.DeployArmToResourceGroupAsync(
                request.SubscriptionNameOrId,
                request.ResourceGroupName,
                templatePath,
                request.ParameterFilePath,
                It.IsAny<Azure.WaitUntil>()))
            .ReturnsAsync(operation);
    }

    private void SetUpFailedGroupDeployment(string reason)
    {
        var operation = SetupDeploymentOperation(false, reason);
        armDeploymentMock.Setup(x => x.DeployArmToResourceGroupAsync(
                It.IsAny<string>(),
                It.IsAny<string>(),
                It.IsAny<string>(),
                It.IsAny<string>(),
                It.IsAny<Azure.WaitUntil>()))
            .ReturnsAsync(operation);
    }

    private void SetUpExceptionThrowingGroupDeployment(Exception ex)
    {
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

    private void SetUpSuccessfulSubDeployment(DeploymentSubRequest request, string templatePath)
    {
        var operation = SetupDeploymentOperation(true, "OK");
        armDeploymentMock.Setup(x => x.DeployArmToSubscriptionAsync(
                request.SubscriptionNameOrId,
                request.Location,
                templatePath,
                request.ParameterFilePath,
                It.IsAny<Azure.WaitUntil>()))
            .ReturnsAsync(operation);
    }

    private void SetUpFailedSubDeployment(string reason)
    {
        var operation = SetupDeploymentOperation(false, reason);
        armDeploymentMock.Setup(x => x.DeployArmToSubscriptionAsync(
                It.IsAny<string>(),
                It.IsAny<string>(),
                It.IsAny<string>(),
                It.IsAny<string>(),
                It.IsAny<Azure.WaitUntil>()))
            .ReturnsAsync(operation);
    }

    private void SetUpExceptionThrowingSubDeployment(Exception ex)
    {
        armDeploymentMock.Setup(x => x.DeployArmToSubscriptionAsync(
                It.IsAny<string>(),
                It.IsAny<string>(),
                It.IsAny<string>(),
                It.IsAny<string>(),
                It.IsAny<Azure.WaitUntil>()))
            .ThrowsAsync(ex);
    }

    private void VerifySubDeployment(DeploymentSubRequest request, string templatePath)
    {
        armDeploymentMock.Verify(x => x.DeployArmToSubscriptionAsync(
                request.SubscriptionNameOrId,
                request.Location,
                templatePath,
                request.ParameterFilePath,
                It.IsAny<Azure.WaitUntil>()),
            Times.Once);
    }

    private void VerifyNoDeployments()
    {
        armDeploymentMock.Verify(x => x.DeployArmToResourceGroupAsync(
                It.IsAny<string>(),
                It.IsAny<string>(),
                It.IsAny<string>(),
                It.IsAny<string>(),
                It.IsAny<Azure.WaitUntil>()),
            Times.Never);

        armDeploymentMock.Verify(x => x.DeployArmToSubscriptionAsync(
                It.IsAny<string>(),
                It.IsAny<string>(),
                It.IsAny<string>(),
                It.IsAny<string>(),
                It.IsAny<Azure.WaitUntil>()),
            Times.Never);
    }
}
