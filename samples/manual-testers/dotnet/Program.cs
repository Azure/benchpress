using Grpc.Net.Client;
using BenchPress.TestEngine;

using var channel = GrpcChannel.ForAddress("http://localhost:5152");
    var client = new Deployment.DeploymentClient(channel);

    var request = new DeploymentSubRequest {
        BicepFilePath = "<path to your bicep file>",
        ParameterFilePath = "<path to your params file, if needed>",
        Location = "eastus",
        SubscriptionNameOrId = "<your subscription id>"
    };

    var result = await client.DeploymentSubCreateAsync(request);

    Console.WriteLine($"Success? {result.Success}");
    Console.WriteLine(result.ErrorMessage);