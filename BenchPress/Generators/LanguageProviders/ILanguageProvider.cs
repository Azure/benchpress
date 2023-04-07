using Generators.ResourceTypes;

namespace Generators.LanguageProviders;

public interface ILanguageProvider
{
    public string Function(string name);
    public string Escape(string value);
    public string Variable(string name);
    public string Value(object value);
    public string AssertionDetails(TestType testType);
    public string Library(ResourceType resourceType);
    public string SDK(SDKFunction sdkFunction);
    public string Parameter(string name);
    public string ParameterList(params string[] parameters);
    public string GetTemplateFileName();
}
