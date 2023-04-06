function MyOtherFunction() {
  Write-Host "$env:LOCATION"
}

$attributeType = @"
using System;
using System.Management.Automation;

[AttributeUsage(AttributeTargets.Method)]
public class MyCustomAttribute : Attribute
{
  public MyCustomAttribute()
  {
    var location = Environment.GetEnvironmentVariable("LOCATION");
    Console.WriteLine(location);

    using (PowerShell ps = PowerShell.Create(RunspaceMode.CurrentRunspace))
    {
      ps.AddCommand("MyOtherFunction");
      ps.Invoke();
    }
  }
}
"@

Add-Type -TypeDefinition $attributeType -Language CSharp

function MyFunction()
{
    Write-Host "MyFunction was called."
}

$MyFunction = Get-Item function:MyFunction
$MyFunction.ScriptBlock.Attributes.Add((New-Object MyCustomAttribute))

MyFunction
