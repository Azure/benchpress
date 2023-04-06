using namespace System;

public class MyCustomAttribute : System.Management.Automation.CmdletBindingAttribute
{
  
}

function MyFunction {
    [MyCustomAttribute]
    param()

    Write-Host "Hello World"
}

MyFunction
