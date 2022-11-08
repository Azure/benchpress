namespace BenchPress.TestEngine.Services;

public interface IArmDeploymentService {
    Task<ArmOperation<ArmDeploymentResource>> DeployArmToResourceGroupAsync(string subscriptionNameOrId, string resourceGroupName, string armTemplatePath, string? parametersPath = null, Azure.WaitUntil waitUtil = Azure.WaitUntil.Completed);
    Task<ArmOperation<ArmDeploymentResource>> DeployArmToSubscriptionAsync(string subscriptionNameOrId, string armTemplatePath, string? parametersPath = null, Azure.WaitUntil waitUtil = Azure.WaitUntil.Completed);
}