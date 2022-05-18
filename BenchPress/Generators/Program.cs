// See https://aka.ms/new-console-template for more information
using Generators;
using Generators.LanguageProviders;
using Generators.ResourceTypes;

var language = new PowershellLanguageProvider();
var generator = new TestGenerator(language);

var metadataList = AzureDeploymentImporter.Import("sample.bicep");
var testList = new List<TestDefinition>();

// Resource exists tests
foreach (var metadata in metadataList)
{
    testList.Add(new TestDefinition(
        metadata,
        TestType.ResourceExists));

    testList.Add(new TestDefinition(
        metadata,
        TestType.Location));
}

var testGroups = new List<IEnumerable<TestDefinition>>();

testGroups.Add(testList.Where(t => t.Metadata.ResourceType.GetType() == typeof(VirtualMachine)));
testGroups.Add(testList.Where(t => t.Metadata.ResourceType.GetType() == typeof(ResourceGroup)));

var templateFile = "./templates/powershell/template.ps1";

foreach (var group in testGroups)
{
    if (!group.Any()) continue;

    var testsOutput = generator.Generate(group, templateFile);

    var testFileName = group.First().Metadata.ResourceType.Prefix + "Tests.ps1";
    var testFilePath = "output";

    var testFileFullName = Path.Join(testFilePath, testFileName);

    if (!Directory.Exists(testFilePath))
    {
        Directory.CreateDirectory(testFilePath);
    }
    
    File.WriteAllText(testFileFullName, testsOutput);
}