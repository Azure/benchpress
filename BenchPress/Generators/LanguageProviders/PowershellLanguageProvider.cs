using Generators.ResourceTypes;

namespace Generators.LanguageProviders;

public class PowershellLanguageProvider : ILanguageProvider
{
    public string Parameter(string name)
    {
        return name;
    }

    public string Value(object value)
    {
        if (value is null)
        {
            return "$null";
        }

        switch (value)
        {
            case String str:
                return $"\"{str}\"";
            case bool b:
                return b ? "$true" : "$false";

            default:
                return value.ToString()!;
        }
    }

    public string AssertionDetails(TestType testType)
    {
        switch (testType)
        {
            case TestType.ResourceExists:
                return "-BeSuccessful";
            default:
                throw new Exception($"Unknown test type: {testType}");
        }
    }

    public string Escape(string value)
    {
        return value.Replace("'", "''");
    }

    public string Library(ResourceType resourceType)
    {
        const string prefix = "$PSScriptRoot/BenchPress/Helpers/Azure/";
        return prefix + resourceType.FunctionPrefix + ".psm1";
    }

    public string SDK(SDKFunction sdkFunction)
    {
        switch (sdkFunction.Kind)
        {
            case TestType.ResourceExists:
                return $"Confirm-AzBPResource";
            default:
                throw new Exception($"Unknown test type: {sdkFunction.Kind}");
        }
    }

    public string GetTemplateFileName()
    {
        return "./templates/powershell/template.ps1";
    }
}
