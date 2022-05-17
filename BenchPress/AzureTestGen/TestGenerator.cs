using Stubble.Core.Builders;

namespace AzureTestGen;

public class TestGenerator
{
    ILanguageProvider LanguageProvider { get; }
    public TestGenerator(ILanguageProvider language)
    {
        LanguageProvider = language;
    }

    // Generate a test snippet from a test definition and razor template file.
    public string Generate(TestDefinition[] definitions, string templateFile)
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
                case TestType.Region:
                    viewModel = GenerateCheckRegionViewModel(definition, template);
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
            new
            {
                TestCases = viewModels,
                ResourceTypes = resourceTypes
            }
        );

        return output;
    }

    private TestViewModel GenerateCheckRegionViewModel(TestDefinition definition, string template)
    {
        var valueToCheckVariable = LanguageProvider.Variable($"{definition.Metadata.ResourceType.Prefix()}Region");
        return new TestViewModel
        {
            Name = LanguageProvider.Escape($"Check {definition.Metadata.ResourceType.FriendlyName()} region"),
            Description = LanguageProvider.Escape($"Check that {definition.Metadata.ResourceType.FriendlyName()} is in the right region"),
            ValueToCheckVariable = valueToCheckVariable,
            GetValueFunctionParameterList = LanguageProvider.ParameterList(
                LanguageProvider.Value(definition.Metadata.ResourceName), 
                valueToCheckVariable),
            ValueToCheck = LanguageProvider.Value(definition.Metadata.ExtraProperties["Location"]),
            ActualValueVariable = LanguageProvider.Variable($"check"),
            GetValueFunctionName = LanguageProvider.SDKFunction(SDKFunction.Default(definition)),
            ExpectedValue = LanguageProvider.Value(true)
        };
    }

    private TestViewModel GenerateResourceExistsViewModel(TestDefinition definition, string template)
    {
        var valueToCheckVariable = LanguageProvider.Variable($"{definition.Metadata.ResourceType.Prefix()}Name");
        return new TestViewModel
        {
            Name = LanguageProvider.Escape($"Verify that {definition.Metadata.ResourceType.FriendlyName()} exists"),
            Description = LanguageProvider.Escape($"It should contain a {definition.Metadata.ResourceType.FriendlyName()} named {definition.Metadata.ResourceName}"),
            ValueToCheckVariable = valueToCheckVariable,
            GetValueFunctionParameterList = LanguageProvider.ParameterList(valueToCheckVariable),
            ValueToCheck = LanguageProvider.Value(definition.Metadata.ResourceName),
            ActualValueVariable = LanguageProvider.Variable($"exists"),
            GetValueFunctionName = LanguageProvider.SDKFunction(SDKFunction.Default(definition)),
            ExpectedValue = LanguageProvider.Value(true)
        };
    }

    private class TestViewModel
    {
        public string ValueToCheckVariable { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string GetValueFunctionParameterList { get; set; }
        public string ValueToCheck { get; set; }
        public string ActualValueVariable { get; set; }
        public string GetValueFunctionName { get; set; }
        public string ExpectedValue { get; set; }
    }
}