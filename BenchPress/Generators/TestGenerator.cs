using Stubble.Core.Builders;
using Generators.LanguageProviders;

namespace Generators;

public class TestGenerator
{
    ILanguageProvider LanguageProvider { get; }

    public TestGenerator(ILanguageProvider language)
    {
        LanguageProvider = language;
    }

    // Generate a test snippet from a test definition and razor template file.
    public string Generate(IEnumerable<TestDefinition> definitions, string templateFile)
    {
        var template = File.ReadAllText(templateFile);

        var viewModels = new List<object>();
        foreach (var definition in definitions)
        {
            object viewModel;
            switch (definition.Type)
            {
                case TestType.ResourceExists:
                    viewModel = GenerateResourceExistsViewModel(definition, template);
                    break;
                default:
                    throw new Exception($"Unknown test type: {definition.Type}");
            }

            viewModels.Add(viewModel);
        }

        var resourceTypes = new List<object>();
        foreach (var resourceType in definitions.Select(d => d.Metadata.ResourceType).Distinct())
        {
            var library = LanguageProvider.Library(resourceType);
            resourceTypes.Add(new { Library = library });
        }

        var stubble = new StubbleBuilder().Build();
        var output = stubble.Render(
            template,
            new { TestCases = viewModels, ResourceTypes = resourceTypes }
        );

        return output;
    }

    private TestViewModel GenerateResourceExistsViewModel(
        TestDefinition definition,
        string template
    )
    {
        var parameters = GetParameters(definition);

        return new TestViewModel
        {
            Parameters = parameters,
            Name = LanguageProvider.Escape(
                $"Verify that {definition.Metadata.ResourceType.FriendlyName} exists"
            ),
            Description = LanguageProvider.Escape(
                $"It should contain a {definition.Metadata.ResourceType.FriendlyName} named {definition.Metadata.ResourceName}"
            ),
            ResultVariable = LanguageProvider.Variable($"result"),
            ActualValue = LanguageProvider.Variable($"result") + ".Success",
            GetValueFunctionName = LanguageProvider.SDK(new SDKFunction(definition)),
            ExpectedValue = LanguageProvider.Value(true)
        };
    }

    private struct TestViewModel
    {
        public IEnumerable<KeyValuePair<string, string>> Parameters { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string ResultVariable { get; set; }
        public string GetValueFunctionName { get; set; }
        public string ActualValue { get; set; }
        public string ExpectedValue { get; set; }
    }

    private IEnumerable<KeyValuePair<string, string>> GetParameters(TestDefinition definition)
    {
        return definition.Metadata.ResourceType
            .GetResourceParameters(definition.Metadata)
            .Select(
                p =>
                    new KeyValuePair<string, string>(
                        LanguageProvider.Parameter(p.Key),
                        LanguageProvider.Value(p.Value)
                    )
            );
    }
}
