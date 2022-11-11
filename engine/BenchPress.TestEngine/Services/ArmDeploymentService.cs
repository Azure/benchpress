using Azure;
using Azure.ResourceManager.Resources.Models;

namespace BenchPress.TestEngine.Services;

public class ArmDeploymentService : IArmDeploymentService
{
    private readonly ArmClient client;
    private readonly IFileService fileService;
    private string NewDeploymentName { get { return $"benchpress-{Guid.NewGuid().ToString()}"; } }

    public ArmDeploymentService(ArmClient client, IFileService fileService)
    {
        this.client = client;
        this.fileService = fileService;
    }

    public async Task<ArmOperation<ArmDeploymentResource>> DeployArmToResourceGroupAsync(string subscriptionNameOrId, string resourceGroupName, string armTemplatePath, string? parametersPath = null, WaitUntil waitUntil = WaitUntil.Completed)
    {
        ValidateParameters(subscriptionNameOrId, resourceGroupName, armTemplatePath);
        SubscriptionResource sub = await client.GetSubscriptions().GetAsync(subscriptionNameOrId);
        ResourceGroupResource rg = await sub.GetResourceGroups().GetAsync(resourceGroupName);
        var deploymentContent = await CreateDeploymentContent(armTemplatePath, parametersPath);
        return await CreateGroupDeployment(rg, waitUntil, NewDeploymentName, deploymentContent);
    }

    public async Task<ArmOperation<ArmDeploymentResource>> DeployArmToSubscriptionAsync(string subscriptionNameOrId, string location, string armTemplatePath, string? parametersPath = null, WaitUntil waitUtil = WaitUntil.Completed)
    {
        ValidateParameters(subscriptionNameOrId, location, armTemplatePath);
        SubscriptionResource sub = await client.GetSubscriptions().GetAsync(subscriptionNameOrId);
        var deploymentContent = await CreateDeploymentContent(armTemplatePath, parametersPath, location);
        return await CreateSubscriptionDeployment(sub, waitUtil, NewDeploymentName, deploymentContent);
    }

    private void ValidateParameters(params string[] parameters)
    {
        if (parameters.Any(s => string.IsNullOrWhiteSpace(s)))
        {
            throw new ArgumentException("One or more parameters were missing or empty");
        }
    }

    private async Task<ArmDeploymentContent> CreateDeploymentContent(string armTemplatePath, string? parametersPath, string? location = null) {
        var templateContent = (await fileService.ReadAllTextAsync(armTemplatePath)).TrimEnd();
        var properties = new ArmDeploymentProperties(ArmDeploymentMode.Incremental)
        {
            Template = BinaryData.FromString(templateContent)
        };

        if (!string.IsNullOrWhiteSpace(parametersPath))
        {
            var parametersContent = (await fileService.ReadAllTextAsync(parametersPath)).TrimEnd();
            properties.Parameters = BinaryData.FromString(parametersContent);
        }

        var content = new ArmDeploymentContent(properties);
        if (!string.IsNullOrWhiteSpace(location))
        {
            content.Location = location;
        }

        return content;
    }

    // These extension methods are wrapped to allow mocking in our tests
    protected virtual async Task<ArmOperation<ArmDeploymentResource>> CreateGroupDeployment(ResourceGroupResource rg, Azure.WaitUntil waitUntil, string deploymentName, ArmDeploymentContent deploymentContent)
    {
        return await rg.GetArmDeployments().CreateOrUpdateAsync(waitUntil, deploymentName, deploymentContent);
    }

    protected virtual async Task<ArmOperation<ArmDeploymentResource>> CreateSubscriptionDeployment(SubscriptionResource sub, Azure.WaitUntil waitUntil, string deploymentName, ArmDeploymentContent deploymentContent)
    {
        return await sub.GetArmDeployments().CreateOrUpdateAsync(waitUntil, deploymentName, deploymentContent);
    }
}
