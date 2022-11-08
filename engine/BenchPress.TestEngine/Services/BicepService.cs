namespace BenchPress.TestEngine.Services;

public class BicepService : Bicep.BicepBase
{
    private readonly ILogger<BicepService> logger;
    private readonly IArmDeploymentService armDeploymentService;

    public BicepService(ILogger<BicepService> logger, IArmDeploymentService armDeploymentService)
    {
        this.logger = logger;
        this.armDeploymentService = armDeploymentService;
    }

    public override async Task<DeploymentResult> DeploymentGroupCreate(DeploymentGroupRequest request, ServerCallContext context)
    {
        if (string.IsNullOrWhiteSpace(request.BicepFilePath)
            || string.IsNullOrWhiteSpace(request.ResourceGroupName)
            || string.IsNullOrWhiteSpace(request.SubscriptionNameOrId)) 
        {
            return new DeploymentResult {
                Success = false,
                ErrorMessage = $"One or more of the following required parameters was missing: {nameof(request.BicepFilePath)}, {nameof(request.ResourceGroupName)}, and {nameof(request.SubscriptionNameOrId)}"
            };
        }

        try {
            // TODO: pass in transpiled arm template instead
            var deployment = await armDeploymentService.DeployArmToResourceGroupAsync(request.SubscriptionNameOrId, request.ResourceGroupName, request.BicepFilePath, request.ParameterFilePath);
            var response = deployment.WaitForCompletionResponse();
            
            return new DeploymentResult {
                Success = !response.IsError,
                ErrorMessage = response.ReasonPhrase
            };

        } catch (Exception ex) {
            return new DeploymentResult {
                Success = false,
                ErrorMessage = ex.Message
            };
        }
    }

    public override async Task<DeploymentResult> DeleteGroup(DeleteGroupRequest request, ServerCallContext context)
    {
        throw new NotImplementedException();
    }
}