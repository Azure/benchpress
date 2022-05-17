namespace AzureTestGen;

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
                return value.ToString();
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
        switch (resourceType)
        {
            case ResourceType.ResourceGroup:
                return prefix + "ResourceGroups.ps1";
            case ResourceType.VirtualMachine:
                return prefix + "VirtualMachines.ps1";
            default:
                throw new Exception($"Unknown resource type: {resourceType}");
        }
    }

    public string SDKFunction(SDKFunction sdkFunction)
    {
        switch (sdkFunction.Kind)
        {
            case TestType.ResourceExists:
                return $"Get-{sdkFunction.ResourceType.FunctionPrefix()}Exists";
            case TestType.Region:
                return $"Check-{sdkFunction.ResourceType.FunctionPrefix()}Region";
            default:
                throw new Exception($"Unknown test type: {sdkFunction.Kind}");
        }
    }

    public string ParameterList(params string[] parameters)
    {
        return string.Join(" ", parameters);
    }
}