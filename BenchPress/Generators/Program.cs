using Generators;
using Generators.LanguageProviders;
using Generators.ResourceTypes;
using System.CommandLine;

var fileOption = new Option<FileInfo?>(name: "--import", description: "The bicep file to import and scaffold tests for");

var rootCommand = new RootCommand("Test Generator for Bicep");

rootCommand.AddOption(fileOption);

rootCommand.SetHandler((file) =>
  {
    if (file is null) return;

    var language = new PowershellLanguageProvider();
    var generator = new TestGenerator(language);

    var metadataList = AzureDeploymentImporter.Import(file);
    var testList = new List<TestDefinition>();

    foreach (var metadata in metadataList)
    {
      testList.Add(new TestDefinition(metadata, TestType.ResourceExists));
      testList.Add(new TestDefinition(metadata, TestType.Location));
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
  },
  fileOption
);

await rootCommand.InvokeAsync(args);
