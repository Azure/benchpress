namespace BenchPress.TestEngine.Services;

public interface IFileService
{
    public bool FileExists(string filePath);
    string GetFileFullPath(string filePath);
    string ChangeFileExtension(string filePath, string extension);
    string GetFileExtension(string filePath);
    Task<string> ReadAllTextAsync(string filePath);
}
