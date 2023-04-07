using Generators;
using Generators.LanguageProviders;
using Generators.ResourceTypes;
using System.CommandLine;
using System.Linq;

var importFileOption = new Option<FileInfo?>(
    name: "--import",
    description: "The bicep file to import and scaffold tests for"
);

var outputFolderOption = new Option<DirectoryInfo?>(
    name: "--output",
    description: "Path that output will be saved"
);

var languageProviderOption = new Option<LanguageProviderOptions>(
    name: "--provider",
    description: "Language provider that will be used to generate test files"
);

var rootCommand = new RootCommand("Test Generator for Bicep and ARM Templates");

rootCommand.AddOption(importFileOption);
rootCommand.AddOption(languageProviderOption);
rootCommand.AddOption(outputFolderOption);

rootCommand.SetHandler(
    (fileInfo, outputFolder, languageProvider) =>
    {
        if (fileInfo is null)
            return;
        if (languageProvider == LanguageProviderOptions.Undefined)
            return;

        var testFilePath = outputFolder?.FullName ?? Path.GetFullPath("output");

        if (!Directory.Exists(testFilePath))
        {
            Directory.CreateDirectory(testFilePath);
        }

        ILanguageProvider provider = languageProvider switch
        {
            LanguageProviderOptions.Powershell => new PowershellLanguageProvider(),
            _ => throw new NotImplementedException(),
        };

        var generator = new TestGenerator(provider);

        var metadataList = AzureDeploymentImporter.Import(fileInfo, testFilePath);

        var testList = new List<TestDefinition>();
        var testGroups = new List<IEnumerable<TestDefinition>>();

        foreach (var metadata in metadataList)
        {
          foreach(var supportedTestType in metadata.ResourceType.GetSupportedTestTypes())
          {
            testList.Add(new TestDefinition(metadata, supportedTestType));
          }
        }

        AppDomain.CurrentDomain
            .GetAssemblies()
            .SelectMany(domainAssembly => domainAssembly.GetTypes())
            .Where(type => typeof(ResourceType).IsAssignableFrom(type) && !type.IsAbstract)
            .ToList()
            .ForEach(type =>
            {
                testGroups.Add(testList.Where(t => t.Metadata.ResourceType.GetType() == type));
            });

        testGroups.Add(
            testList.Where(t => t.Metadata.ResourceType.GetType() == typeof(ResourceGroup))
        );

        foreach (var group in testGroups)
        {
            if (!group.Any())
                continue;

            var testsOutput = generator.Generate(group, provider.GetTemplateFileName());

            var testFileName = group.First().Metadata.ResourceType.Prefix + ".Tests.ps1";

            var testFileFullName = Path.Join(testFilePath, testFileName);

            File.WriteAllText(testFileFullName, testsOutput);
        }
    },
    importFileOption,
    outputFolderOption,
    languageProviderOption
);

await rootCommand.InvokeAsync(args);

public enum LanguageProviderOptions
{
    Undefined,
    Powershell,
    NodeJs,
}
