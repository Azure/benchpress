using Generators.ResourceTypes;

namespace Generators.LanguageProviders;

public class PowershellLanguageProvider : ILanguageProvider
{
    public string Variable(string name)
    {
        return $"${name}";
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

    public string Function(string name)
    {
        return name;
    }

    public string Escape(string value)
    {
        return value.Replace("'", "''");
    }

    public string Library(ResourceType resourceType)
    {
        const string prefix = "$PSScriptRoot/BenchPress/Helpers/Azure/";
        return prefix + resourceType.FunctionPrefix + ".ps1";
    }

    public string SDK(SDKFunction sdkFunction)
    {
        switch (sdkFunction.Kind)
        {
            case TestType.ResourceExists:
                return $"Get-{sdkFunction.ResourceType.FunctionPrefix}Exists";
            case TestType.Location:
                return $"Check-{sdkFunction.ResourceType.FunctionPrefix}Location";
            default:
                throw new Exception($"Unknown test type: {sdkFunction.Kind}");
        }
    }

    public string ParameterList(params string[] parameters)
    {
        return string.Join(" ", parameters);
    }
}