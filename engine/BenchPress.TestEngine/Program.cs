using BenchPress.TestEngine.Services;
using Microsoft.AspNetCore.Server.Kestrel.Core;
using Microsoft.Extensions.Azure;
using Azure.Identity;

var builder = WebApplication.CreateBuilder(args);

// Additional configuration is required to successfully run gRPC on macOS.
// For instructions on how to configure Kestrel and gRPC clients on macOS, visit https://go.microsoft.com/fwlink/?linkid=2099682
builder.WebHost.ConfigureKestrel(options =>
{
    // Setup a HTTP/2 endpoint without TLS.
    options.ListenLocalhost(5152, o => o.Protocols =
        HttpProtocols.Http2);
});

// Add services to the container.
builder.Services.AddGrpc();
builder.Services.AddAzureClients(builder => {
    builder.AddClient<ArmClient, ArmClientOptions>(options => {
        return new ArmClient(new DefaultAzureCredential());
    });
});
builder.Services.AddSingleton<IArmDeploymentService, ArmDeploymentService>();
builder.Services.AddSingleton<IBicepTranspileService, BicepTranspileService>();
builder.Services.AddSingleton<IBicepExecute, BicepExecute>();

var app = builder.Build();

// Configure the HTTP request pipeline.
app.MapGrpcService<DeploymentService>();
app.MapGrpcService<ResourceGroupService>();
app.MapGet("/", () => "Communication with gRPC endpoints must be made through a gRPC client. To learn how to create a client, visit: https://go.microsoft.com/fwlink/?linkid=2086909");

app.Run();
