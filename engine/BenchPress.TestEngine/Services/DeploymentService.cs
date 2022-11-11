namespace BenchPress.TestEngine.Services;

public class DeploymentService : Deployment.DeploymentBase
{

    private readonly ILogger<DeploymentService> logger;
    private readonly IBicepTranspileService bicepTranspileService;
    private readonly IArmDeploymentService armDeploymentService;

    public DeploymentService(ILogger<DeploymentService> logger, IBicepTranspileService bicepTranspileService, IArmDeploymentService armDeploymentService)
    {
        this.logger = logger;
        this.bicepTranspileService = bicepTranspileService;
        this.armDeploymentService = armDeploymentService;
    }

    public override async Task<DeploymentResult> DeploymentGroupCreate(DeploymentGroupRequest request, ServerCallContext context)
    {
        if (string.IsNullOrWhiteSpace(request.BicepFilePath)
            || string.IsNullOrWhiteSpace(request.ResourceGroupName)
            || string.IsNullOrWhiteSpace(request.SubscriptionNameOrId))
        {
            return new DeploymentResult
            {
                Success = false,
                ErrorMessage = $"One or more of the following required parameters was missing: {nameof(request.BicepFilePath)}, {nameof(request.ResourceGroupName)}, and {nameof(request.SubscriptionNameOrId)}"
            };
        }

        try
        {
            var armTemplatePath = await bicepTranspileService.BuildAsync(request.BicepFilePath);
            var deployment = await armDeploymentService.DeployArmToResourceGroupAsync(request.SubscriptionNameOrId, request.ResourceGroupName, armTemplatePath, request.ParameterFilePath);
            var response = deployment.WaitForCompletionResponse();

            return new DeploymentResult
            {
                Success = !response.IsError,
                ErrorMessage = response.ReasonPhrase
            };
        }
        catch (Exception ex)
        {
            return new DeploymentResult
            {
                Success = false,
                ErrorMessage = ex.Message
            };
        }
    }

    public override async Task<DeploymentResult> DeploymentSubCreate(DeploymentSubRequest request, ServerCallContext context)
    {
        if (string.IsNullOrWhiteSpace(request.BicepFilePath)
            || string.IsNullOrWhiteSpace(request.Location)
            || string.IsNullOrWhiteSpace(request.SubscriptionNameOrId))
        {
            return new DeploymentResult
            {
                Success = false,
                ErrorMessage = $"One or more of the following required parameters was missing: {nameof(request.BicepFilePath)}, {nameof(request.Location)}, and {nameof(request.SubscriptionNameOrId)}"
            };
        }

        try
        {
            var armTemplatePath = await bicepTranspileService.BuildAsync(request.BicepFilePath);
            var deployment = await armDeploymentService.DeployArmToSubscriptionAsync(request.SubscriptionNameOrId, request.Location, armTemplatePath, request.ParameterFilePath);
            var response = deployment.WaitForCompletionResponse();

            return new DeploymentResult
            {
                Success = !response.IsError,
                ErrorMessage = response.ReasonPhrase
            };
        }
        catch (Exception ex)
        {
            return new DeploymentResult
            {
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
