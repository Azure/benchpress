# Manually Testing the Test Engine

Ideally, when a Test Engine method needs to be E2E tested, we would run one of the Test Frameworks against the Engine. The Test Framework would already know how to spin up the Engine, make gRPC calls, and kill the Engine. So, testing the Engine would be as simple as calling the Engine method from within the Framework.

Unfortunately, a Test Framework might not be ready to successfully call the Test Engine method that you want to test. In this case, we can write our own gRPC Client to call the Engine's gRPC endpoint and verify that it works.

## Running the Engine

First, ensure that your machine is authenticated with Azure by running `az login`.

From the `/engine/BenchPress.TestEngine/` folder, start the server with `dotnet run`. When the gRPC Server starts, it will output what port it is running on (in this case, `5152`).

```bash
info: Microsoft.Hosting.Lifetime[14]
      Now listening on: http://localhost:5152
info: Microsoft.Hosting.Lifetime[0]
      Application started. Press Ctrl+C to shut down.
info: Microsoft.Hosting.Lifetime[0]
      Hosting environment: Production
info: Microsoft.Hosting.Lifetime[0]
      Content root path: /workspaces/benchpress-private/engine/BenchPress.TestEngine/
```

## Writing a Client

The following Client code examples can be found under `/samples/manual-testers/`.

### C#

Create a new C# Project to make calls to the Test Engine.

Ensure that the `.csproj` file references the necessary gRPC packages...

```xml
  <ItemGroup>
    <PackageReference Include="Google.Protobuf" Version="3.21.6" />
    <PackageReference Include="Grpc.Net.Client" Version="2.49.0" />
    <PackageReference Include="Grpc.Tools" Version="2.49.1">
      <IncludeAssets>runtime; build; native; contentfiles; analyzers; buildtransitive</IncludeAssets>
      <PrivateAssets>all</PrivateAssets>
    </PackageReference>
  </ItemGroup>
```

... and the `.proto` files. Make sure they are marked as Client, not Server.

```xml
  <ItemGroup>
    <Protobuf Include="../../../protos/deployment.proto" GrpcServices="Client" />
    <Protobuf Include="../../../protos/resource_group.proto" GrpcServices="Client" />
  </ItemGroup>
```

In the `.cs` file that will be calling the Test Engine method, include the following `using` statements:

```csharp
using Grpc.Net.Client;
using BenchPress.TestEngine;
```

Your editor's intellisense should now be able to pick up on the objects and interfaces defined in the .proto files.

Start by creating the gRPC Channel using the port that the Test Engine is running on:

```csharp
using var channel = GrpcChannel.ForAddress("http://localhost:5152");
```

Then, create the client(s) that define the Test Engine method(s) you wish to call:

```csharp
var deployClient = new Deployment.DeploymentClient(channel);
var rgClient = new ResourceGroup.ResourceGroupClient(channel);
```

Now you can build your Request objects...

```csharp
var request = new DeploymentGroupRequest {
    BicepFilePath = "main.bicep",
    ParameterFilePath = "params.json",
    ResourceGroupName = "rg-jsmith-benchpress-test",
    SubscriptionNameOrId = "John-Smiths-Subscription"
};
```

... and make calls to the Test Engine

```csharp
var result = await deployClient.DeploymentGroupCreateAsync(request);
```

Altogether, you may have a simple console app `Program.cs` that looks like this:

```csharp
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
```

While the Test Engine is running in a separate terminal, run your Client code. Using this Client, you can manually test the Test Engine.

### Python

If needed, generate the `pb2` scripts for the `.proto` files you will be using. (They might already exist in under `/framework/python/src/benchpress`).

```bash
python -m grpc_tools.protoc -I./protos --python_out=. --grpc_python_out=. ./protos/deployment.proto
```

The above example ran at the root of the project directory will create a `deployment_pb2.py` and `deployment_pb2_grpc.py` file.

In the python script you will be using for your tests, include the following import statements (for whatever `pb2` files you are going to use):

```python
import grpc
import deployment_pb2
import deployment_pb2_grpc
import resource_group_pb2
import resource_group_pb2_grpc
```

Start by creating the gRPC Channel using the port that the Test Engine is running on:

```python
with grpc.insecure_channel('localhost:5152') as channel:
```

Then, create the client(s) that define the Test Engine method(s) you wish to call:

```python
deployStub = deployment_pb2_grpc.DeploymentStub(channel)
rgStub = resource_group_pb2_grpc.ResourceGroupStub(channel)
```

Now you can build your Request objects...

```python
req = deployment_pb2.DeploymentGroupRequest(
    bicep_file_path = 'main.bicep',
    parameter_file_path = 'params.json',
    resource_group_name = 'rg-jsmith-benchpress-test',
    subscription_name_or_id = 'John-Smiths-Subscription'
    )
```

... and make calls to the Test Engine

```python
response = deployStub.DeploymentGroupCreate(req)
```

Altogether, you may have a python script like this:

```python
from __future__ import print_function

import logging

import grpc
import deployment_pb2
import deployment_pb2_grpc


def run():
    with grpc.insecure_channel('localhost:5152') as channel:
        stub = deployment_pb2_grpc.DeploymentStub(channel)
        req = deployment_pb2.DeploymentSubRequest(
            bicep_file_path = '<path to your bicep file>',
            parameter_file_path = '<path to your params file, if needed>',
            location = 'eastus',
            subscription_name_or_id = '<your subscription id>'
            )
        response = stub.DeploymentSubCreate(req)
    print("Success? " + response.success)
    print(response.error_message)


if __name__ == '__main__':
    logging.basicConfig()
    run()

```

While the Test Engine is running in a separate terminal, run your Client script. Using this Client, you can manually test the Test Engine.