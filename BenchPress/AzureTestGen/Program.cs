// See https://aka.ms/new-console-template for more information
using AzureTestGen;

var language = new PowershellLanguageProvider();
var generator = new TestGenerator(language);

#region Metadata
var rgMetadata = new TestMetadata(
    "Microsoft.Resources/resourceGroups",
    "MyResourceGroup",
    new Dictionary<string, object>() {
        { "Location", "westus" }
    }
);

var vmMetadata = new TestMetadata(
    "Microsoft.Compute/virtualMachines",
    "MyVM",
    new Dictionary<string, object>() {
        { "Location", "westus" },
        { "Size", "Standard_D1_v2" },
        { "OSDiskSize", "30" },
        { "VMSize", "Standard_D1_v2" },
        { "Image", "Canonical:UbuntuServer:16.04-LTS:latest" },
        { "AdminUsername", "admin" },
        { "AdminPassword", "Password123!" },
        { "AuthenticationType", "Password" },
        { "PublicIPAddress", "true" },
        { "PublicIPAddressName", "MyPublicIP" },
        { "PublicIPAddressType", "Dynamic" },
        { "PublicIPAddressAllocation", "Dynamic" },
        { "PublicIPAddressDnsSettings", "Dynamic" },
        { "PublicIPAddressDomainNameLabel", "MyPublicIP" },
        { "PublicIPAddressIdleTimeoutInMinutes", "30" },
        { "PublicIPAddressRoutingMethod", "Dynamic" },
        { "PublicIPAddressVersion", "IPv4" },
        { "PublicIPAddressZone", "westus" },
        { "PublicIPAddressSku", "Standard" },
        { "PublicIPAddressTags", "MyTag" },
        { "PublicIPAddressId", "MyPublicIP" },
        { "PublicIPAddressIpConfigurations", "MyPublicIP" },
        { "PublicIPAddressIpConfigurationsId", "MyPublicIP" },
        { "PublicIPAddressIpConfigurationsName", "MyPublicIP" },
        { "PublicIPAddressIpConfigurationsType", "Dynamic" },
        { "PublicIPAddressIpConfigurationsAllocation", "Dynamic" },
        { "PublicIPAddressIpConfigurationsDnsSettings", "Dynamic" },
        { "PublicIPAddressIpConfigurationsDomainNameLabel", "MyPublicIP" },
        { "PublicIPAddressIpConfigurationsIdleTimeoutInMinutes", "30"}
    }
);

#endregion

var rgExistsTest = new TestDefinition() {
    Type = TestType.ResourceExists,
    Metadata = rgMetadata
};

var vmExistsTest = new TestDefinition() {
    Type = TestType.ResourceExists,
    Metadata = vmMetadata
};

var vmCheckRegion = new TestDefinition() {
    Type = TestType.Region,
    Metadata = vmMetadata
};

var generatedTest = generator.Generate(
    new [] {rgExistsTest, vmExistsTest, vmCheckRegion}, 
    "./templates/powershell/template.ps1"
);

File.WriteAllText("output.ps1", generatedTest);
