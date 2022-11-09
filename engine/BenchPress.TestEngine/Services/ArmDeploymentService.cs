using Azure;
using Azure.ResourceManager.Resources.Models;

namespace BenchPress.TestEngine.Services;

public class ArmDeploymentService : IArmDeploymentService {
    private readonly ArmClient client;
    private string NewDeploymentName { get { return $"benchpress-{Guid.NewGuid().ToString()}"; } }

    public ArmDeploymentService(ArmClient client) {
        this.client = client;
    }

    public async Task<ArmOperation<ArmDeploymentResource>> DeployArmToResourceGroupAsync(string subscriptionNameOrId, string resourceGroupName, string armTemplatePath, string? parametersPath = null, WaitUntil waitUntil = WaitUntil.Completed)
    {
        ValidateParameters(subscriptionNameOrId, resourceGroupName, armTemplatePath);
        SubscriptionResource sub = await client.GetSubscriptions().GetAsync(subscriptionNameOrId);
        ResourceGroupResource rg = await sub.GetResourceGroups().GetAsync(resourceGroupName);
        var deploymentContent = await CreateDeploymentContent(armTemplatePath, parametersPath);
        return await CreateGroupDeployment(rg, waitUntil, NewDeploymentName, deploymentContent);
    }

    public async Task<ArmOperation<ArmDeploymentResource>> DeployArmToSubscriptionAsync(string subscriptionNameOrId, string armTemplatePath, string? parametersPath = null, WaitUntil waitUtil = WaitUntil.Completed)
    {
        ValidateParameters(subscriptionNameOrId, armTemplatePath);
        SubscriptionResource sub = await client.GetSubscriptions().GetAsync(subscriptionNameOrId);
        var deploymentContent = await CreateDeploymentContent(armTemplatePath, parametersPath);
        return await CreateSubscriptionDeployment(sub, waitUtil, NewDeploymentName, deploymentContent);
    }

    private void ValidateParameters(params string[] parameters) {
        if(parameters.Any(s => string.IsNullOrWhiteSpace(s))) {
            throw new ArgumentException("One or more parameters were missing or empty");
        }
    }

    private async Task<ArmDeploymentContent> CreateDeploymentContent(string armTemplatePath, string? parametersPath) {
        var templateContent = (await File.ReadAllTextAsync(armTemplatePath)).TrimEnd();
        var properties = new ArmDeploymentProperties(ArmDeploymentMode.Incremental) {
            Template = BinaryData.FromString(templateContent)
        };

        if (!string.IsNullOrWhiteSpace(parametersPath)) {
            var paramteresContent = (await File.ReadAllTextAsync(parametersPath)).TrimEnd();
            properties.Parameters = BinaryData.FromString(parametersPath);
        }

        return new ArmDeploymentContent(properties);
    }

    // These extension methods are wrapped to allow mocking in our tests
    protected virtual async Task<ArmOperation<ArmDeploymentResource>> CreateGroupDeployment(ResourceGroupResource rg, Azure.WaitUntil waitUntil, string deploymentName, ArmDeploymentContent deploymentContent) {
        return await rg.GetArmDeployments().CreateOrUpdateAsync(waitUntil, deploymentName, deploymentContent);
    }

    protected virtual async Task<ArmOperation<ArmDeploymentResource>> CreateSubscriptionDeployment(SubscriptionResource sub, Azure.WaitUntil waitUntil, string deploymentName, ArmDeploymentContent deploymentContent) {
        return await sub.GetArmDeployments().CreateOrUpdateAsync(waitUntil, deploymentName, deploymentContent);
    }
}
