namespace BenchPress.TestEngine.Services;

public class FileService : IFileService
{
    public bool FileExists(string filePath)
    {
        FileInfo file = new FileInfo(filePath);
        return file.Exists;
    }
    public string GetFileFullPath(string filePath)
    {
        return Path.GetFullPath(filePath);
    }
    public string GetFileExtension(string filePath)
    {
        return Path.GetExtension(filePath);
    }
    public string ChangeFileExtension(string filePath, string extension)
    {
        return Path.ChangeExtension(filePath, extension);
    }
    public async Task<string> ReadAllTextAsync(string filePath)
    {
        return await File.ReadAllTextAsync(filePath);
    }
}
