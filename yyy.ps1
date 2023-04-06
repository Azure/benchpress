function Connect-Account() {
}

$attributeType = @"
using System;

[AttributeUsage(AttributeTargets.Method)]
public class MyCustomAttribute : Attribute
{
    public MyCustomAttribute()
    {
      var location = Environment.GetEnvironmentVariable("LOCATION");

      Console.WriteLine(location);
    }
}
"@

Add-Type -TypeDefinition $attributeType -Language CSharp

function MyFunction()
{
  Write-Host "Hello World"
}

$MyFunction = Get-Item function:MyFunction
$MyFunction.ScriptBlock.Attributes.Add((New-Object MyCustomAttribute))

MyFunction
