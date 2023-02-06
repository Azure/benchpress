# Benchpress Demo Application

This demo application is used to demonstrate the capabilities of Benchpress. It is a simple ASP.NET Core application that has been instrumented with Benchpress. The application is deployed to Azure and then Benchpress is used to run the tests against the application.

## Guidelines for creating and testing a demo application

* Clone AspNetCore.Docs repository

```powershell
git clone https://github.com/dotnet/AspNetCore.Docs.git
```

* Create a new resource group with a unique name

```powershell
$suffix = (Get-Random).ToString("x8")
$location = "westus2"

az group create --name "benchpress-rg-${suffix}" --location "${location}"
```

* Deploy the demo application infrastructure

  * [Application Insights](https://learn.microsoft.com/en-us/azure/azure-monitor/app/app-insights-overview?tabs=net)
  * [Action Group](https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/action-groups)
  * [App Service Plan](https://learn.microsoft.com/en-us/azure/app-service/overview)
  * [Web App](https://azure.microsoft.com/en-us/products/app-service/web)

```powershell
az deployment group create --resource-group "benchpress-rg-${suffix}" --template-file "main.bicep" --parameters suffix="${suffix}"
```

* Go to the demo application folder

```powershell
Push-Location -Path .\AspNetCore.Docs\aspnetcore\mvc\controllers\filters\samples\6.x\FiltersSample
```

* Deploy the demo application

```powershell
az webapp up --name "benchpress-web-${suffix}" --resource-group "benchpress-rg-${suffix}" --location "${location}" --sku "F1"
```

* Go back to the previous directory

```powershell
Pop-Location
```

## Running the tests

* Setup the environment variables

```powershell
# Can be retrieved from the output of the deploy command
$env:ENVIRONMENT_SUFFIX = "${suffix}"
```

* Run the tests by calling the test script file, or, `Invoke-Pester` command

```powershell
./DemoApp.Tests.ps1
```

```powershell
Invoke-Pester
```

## Cleaning up the demo application

* Delete the resource group

```powershell
az group delete --name "benchpress-rg-${suffix}" --yes
```

## Running the deployment, tests, and cleanup together

```powershell
git clone https://github.com/dotnet/AspNetCore.Docs.git

$suffix = (Get-Random).ToString("x8")
$location = "westus3"

az group create --name "benchpress-rg-${suffix}" --location "${location}"

az deployment group create --resource-group "benchpress-rg-${suffix}" --template-file "main.bicep" --parameters suffix="${suffix}"

Push-Location -Path .\AspNetCore.Docs\aspnetcore\mvc\controllers\filters\samples\6.x\FiltersSample

az webapp up --name "benchpress-web-${suffix}" --resource-group "benchpress-rg-${suffix}" --location "${location}" --sku "F1"

Pop-Location

$env:ENVIRONMENT_SUFFIX = "${suffix}"

./DemoApp.Tests.ps1

az group delete --name "benchpress-rg-${suffix}" --yes
```
