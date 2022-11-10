using Azure;
using Azure.ResourceManager;
using Azure.ResourceManager.Resources;
using Azure.ResourceManager.Resources.Models;

namespace BenchPress.TestEngine.Tests;

public class ArmDeploymentServiceTests {
    private readonly ArmDeploymentService armDeploymentService;
    private readonly Mock<ArmClient> armClientMock;
    private readonly Mock<IFileService> fileServiceMock;
    private readonly Mock<ArmDeploymentCollection> groupDeploymentsMock;
    private readonly Mock<ArmDeploymentCollection> subscriptionDeploymentsMock;
    private const string validSubId = "a3a01f37-665c-4ee8-9bc3-3adf7ebcec0d";
    private const string validRgName = "test-rg";
    private const string validLocation = "eastus";
    private const string standaloneTemplate = "storage-account.json";
    private const string templateWithParams = "storage-account-needs-params.json";
    private const string parameters = "params.json";

    public ArmDeploymentServiceTests()
    {
        armClientMock = new Mock<ArmClient>(MockBehavior.Strict);
        fileServiceMock = new Mock<IFileService>(MockBehavior.Strict);
        groupDeploymentsMock = new Mock<ArmDeploymentCollection>();
        subscriptionDeploymentsMock = new Mock<ArmDeploymentCollection>();
        armDeploymentService = new TestArmDeploymentService(groupDeploymentsMock.Object, subscriptionDeploymentsMock.Object, armClientMock.Object, fileServiceMock.Object);
        fileServiceMock.Setup(fs => fs.ReadAllTextAsync(It.IsAny<string>())).ThrowsAsync(new FileNotFoundException());
        fileServiceMock.Setup(fs => fs.ReadAllTextAsync(It.IsIn(new [] {standaloneTemplate, templateWithParams, parameters}))).ReturnsAsync("");
    }

    [Fact]
    public async Task DeployArmToResourceGroupAsync_Deploys()
    {
        var subMock = SetUpSubscriptionMock(validSubId);
        var rgMock = SetUpResourceGroupMock(subMock, validRgName);
        SetUpDeploymentsMock(groupDeploymentsMock);
        await armDeploymentService.DeployArmToResourceGroupAsync(validSubId, validRgName, templateWithParams, parameters);
        VerifyDeploymentsMock(groupDeploymentsMock);
    }

    [Theory]
    [InlineData("main.bicep", "", "a3a01f37-665c-4ee8-9bc3-3adf7ebcec0d")]
    [InlineData("", "rg-test", "a3a01f37-665c-4ee8-9bc3-3adf7ebcec0d")]
    [InlineData("main.bicep", "rg-test", "")]
    public async Task DeployArmToResourceGroupAsync_MissingParameter_ThrowsException(string templatePath, string rgName, string subId)
    {
        var subMock = SetUpSubscriptionMock(subId);
        var rgMock = SetUpResourceGroupMock(subMock, rgName);
        SetUpDeploymentsMock(groupDeploymentsMock);
        var ex = await Assert.ThrowsAsync<ArgumentException>(
            async () => await armDeploymentService.DeployArmToResourceGroupAsync(subId, rgName, templatePath)
        );
        Assert.Equal("One or more parameters were missing or empty", ex.Message);
    }

    [Fact]
    public async Task DeployArmToResourceGroupAsync_InvalidTemplate_ThrowsException()
    {
        var subMock = SetUpSubscriptionMock(validSubId);
        var rgMock = SetUpResourceGroupMock(subMock, validRgName);
        var expectedMessage = "Deployment template validation failed";
        SetUpDeploymentExceptionMock(groupDeploymentsMock, new RequestFailedException(expectedMessage));
        var ex = await Assert.ThrowsAsync<RequestFailedException>(
            async () => await armDeploymentService.DeployArmToResourceGroupAsync(validSubId, validRgName, templateWithParams)
        );
        Assert.Equal(expectedMessage, ex.Message);
    }

    [Fact]
    public async Task DeployArmToResourceGroupAsync_SubscriptionNotFound_ThrowsException()
    {
        var subMock = SetUpSubscriptionMock(validSubId);
        var rgMock = SetUpResourceGroupMock(subMock, validRgName);
        SetUpDeploymentsMock(groupDeploymentsMock);
        var ex = await Assert.ThrowsAsync<RequestFailedException>(
            async () => await armDeploymentService.DeployArmToResourceGroupAsync("The Wrong Subscription", validRgName, standaloneTemplate)
        );
        Assert.Equal("Subscription Not Found", ex.Message);
    }

    [Fact]
    public async Task DeployArmToResourceGroupAsync_ResourceGroupNotFound_ThrowsException()
    {
        var subMock = SetUpSubscriptionMock(validSubId);
        var rgMock = SetUpResourceGroupMock(subMock, validRgName);
        SetUpDeploymentsMock(groupDeploymentsMock);
        var ex = await Assert.ThrowsAsync<RequestFailedException>(
            async () => await armDeploymentService.DeployArmToResourceGroupAsync(validSubId, "the-wrong-rg", standaloneTemplate)
        );
        Assert.Equal("Resource Group Not Found", ex.Message);
    }

    [Fact]
    public async Task DeployArmToSubscriptionAsync_Deploys()
    {
        var subMock = SetUpSubscriptionMock(validSubId);
        SetUpDeploymentsMock(subscriptionDeploymentsMock);
        await armDeploymentService.DeployArmToSubscriptionAsync(validSubId, validLocation, templateWithParams, parameters);
        VerifyDeploymentsMock(subscriptionDeploymentsMock);
    }

    [Theory]
    [InlineData("main.bicep", "", "a3a01f37-665c-4ee8-9bc3-3adf7ebcec0d")]
    [InlineData("", "eastus", "a3a01f37-665c-4ee8-9bc3-3adf7ebcec0d")]
    [InlineData("main.bicep", "eastus", "")]
    public async Task DeployArmToSubscriptionAsync_MissingParameter_ThrowsException(string templatePath, string location, string subId)
    {
        var subMock = SetUpSubscriptionMock(subId);
        SetUpDeploymentsMock(subscriptionDeploymentsMock);
        var ex = await Assert.ThrowsAsync<ArgumentException>(
            async () => await armDeploymentService.DeployArmToSubscriptionAsync(subId, location, templatePath)
        );
        Assert.Equal("One or more parameters were missing or empty", ex.Message);
    }

    [Fact]
    public async Task DeployArmToSubscriptionAsync_InvalidTemplate_ThrowsException()
    {
        var subMock = SetUpSubscriptionMock(validSubId);
        var excepectedMessage = "Deployment template validation failed";
        SetUpDeploymentExceptionMock(subscriptionDeploymentsMock, new RequestFailedException(excepectedMessage));
        var ex = await Assert.ThrowsAsync<RequestFailedException>(
            async () => await armDeploymentService.DeployArmToSubscriptionAsync(validSubId, validLocation, templateWithParams)
        );
        Assert.Equal(excepectedMessage, ex.Message);
    }

    [Fact]
    public async Task DeployArmToSubscriptionAsync_SubscriptionNotFound_ThrowsException()
    {
        var subMock = SetUpSubscriptionMock(validSubId);
        SetUpDeploymentsMock(subscriptionDeploymentsMock);
        var ex = await Assert.ThrowsAsync<RequestFailedException>(
            async () => await armDeploymentService.DeployArmToSubscriptionAsync("The Wrong Subscription", validLocation, standaloneTemplate)
        );
        Assert.Equal("Subscription Not Found", ex.Message);
    }

    [Fact]
    public async Task CreateDeploymentContent_WithoutParameters()
    {
        var subMock = SetUpSubscriptionMock(validSubId);
        SetUpDeploymentsMock(subscriptionDeploymentsMock);
        await armDeploymentService.DeployArmToSubscriptionAsync(validSubId, validLocation, standaloneTemplate);
        VerifyDeploymentsMock(subscriptionDeploymentsMock);
    }

    [Fact]
    public async Task CreateDeploymentContent_WithoutLocation()
    {
        var subMock = SetUpSubscriptionMock(validSubId);
        var rgMock = SetUpResourceGroupMock(subMock, validRgName);
        SetUpDeploymentsMock(groupDeploymentsMock);
        await armDeploymentService.DeployArmToResourceGroupAsync(validSubId, validRgName, standaloneTemplate);
        VerifyDeploymentsMock(groupDeploymentsMock);
    }

    [Fact]
    public async Task CreateDeploymentContent_TemplateNotFound_ThrowsException()
    {
        var subMock = SetUpSubscriptionMock(validSubId);
        var rgMock = SetUpResourceGroupMock(subMock, validRgName);
        SetUpDeploymentsMock(groupDeploymentsMock);
        var ex = await Assert.ThrowsAsync<FileNotFoundException>(
            async () => await armDeploymentService.DeployArmToResourceGroupAsync(validSubId, validRgName, "invalid-file.json")
        );
    }

    [Fact]
    public async Task CreateDeploymentContent_ParametersNotFound_ThrowsException()
    {
        var subMock = SetUpSubscriptionMock(validSubId);
        var rgMock = SetUpResourceGroupMock(subMock, validRgName);
        SetUpDeploymentsMock(groupDeploymentsMock);
        var ex = await Assert.ThrowsAsync<FileNotFoundException>(
            async () => await armDeploymentService.DeployArmToResourceGroupAsync(validSubId, validRgName, standaloneTemplate, "invalid-file.json")
        );
    }

    private Mock<SubscriptionResource> SetUpSubscriptionMock(string nameOrId)
    {
        var subMock = new Mock<SubscriptionResource>();
        var collectionMock = new Mock<SubscriptionCollection>();
        var response = Azure.Response.FromValue(subMock.Object, Mock.Of<Azure.Response>());
        collectionMock.Setup(x => x.GetAsync(It.IsAny<string>(), default)).ThrowsAsync(new Azure.RequestFailedException("Subscription Not Found"));
        collectionMock.Setup(x => x.GetAsync(nameOrId, default)).ReturnsAsync(response);
        armClientMock.Setup(x => x.GetSubscriptions()).Returns(collectionMock.Object);
        return subMock;
    }

    private Mock<ResourceGroupResource> SetUpResourceGroupMock(Mock<SubscriptionResource> subMock, string rgName)
    {
        var rgMock = new Mock<ResourceGroupResource>();
        var collectionMock = new Mock<ResourceGroupCollection>();
        var response = Azure.Response.FromValue(rgMock.Object, Mock.Of<Azure.Response>());
        collectionMock.Setup(x => x.GetAsync(It.IsAny<string>(), default)).ThrowsAsync(new Azure.RequestFailedException("Resource Group Not Found"));
        collectionMock.Setup(x => x.GetAsync(rgName, default)).ReturnsAsync(response);
        subMock.Setup(x => x.GetResourceGroups()).Returns(collectionMock.Object);
        return rgMock;
    }

    private void SetUpDeploymentsMock(Mock<ArmDeploymentCollection> deploymentsMock)
    {
        deploymentsMock.Setup(x => x.CreateOrUpdateAsync(
                It.IsAny<Azure.WaitUntil>(),
                It.IsAny<string>(),
                It.IsAny<ArmDeploymentContent>(),
                default))
            .ReturnsAsync(Mock.Of<ArmOperation<ArmDeploymentResource>>());
    }

    private void SetUpDeploymentExceptionMock<T>(Mock<ArmDeploymentCollection> deploymentsMock, T exception) where T : Exception
    {
        deploymentsMock.Setup(x => x.CreateOrUpdateAsync(
                It.IsAny<Azure.WaitUntil>(),
                It.IsAny<string>(),
                It.IsAny<ArmDeploymentContent>(),
                default))
            .ThrowsAsync(exception);
    }

    private void VerifyDeploymentsMock(Mock<ArmDeploymentCollection> deploymentsMock)
    {
        deploymentsMock.Verify(x => x.CreateOrUpdateAsync(
                It.IsAny<Azure.WaitUntil>(),
                It.IsAny<string>(),
                It.IsAny<ArmDeploymentContent>(),
                default),
            Times.Once);
    }

    // This test class mocks the extension methods for GetArmDeployments()
    private class TestArmDeploymentService : ArmDeploymentService {
        private readonly ArmDeploymentCollection rgDeploymentCollection;
        private readonly ArmDeploymentCollection subDeploymentCollection;

        public TestArmDeploymentService(ArmDeploymentCollection rgDeploymentCollection, ArmDeploymentCollection subDeploymentCollection, ArmClient client, IFileService fileService) : base(client, fileService)
        {
            this.rgDeploymentCollection = rgDeploymentCollection;
            this.subDeploymentCollection = subDeploymentCollection;
        }

        protected override Task<ArmOperation<ArmDeploymentResource>> CreateGroupDeployment(ResourceGroupResource rg, WaitUntil waitUntil, string deploymentName, ArmDeploymentContent deploymentContent)
        {
            return rgDeploymentCollection.CreateOrUpdateAsync(waitUntil, deploymentName, deploymentContent);
        }

        protected override Task<ArmOperation<ArmDeploymentResource>> CreateSubscriptionDeployment(SubscriptionResource sub, WaitUntil waitUntil, string deploymentName, ArmDeploymentContent deploymentContent)
        {
            return subDeploymentCollection.CreateOrUpdateAsync(waitUntil, deploymentName, deploymentContent);
        }
    }
}
