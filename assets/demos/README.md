<!-- markdownlint-disable MD013 -->

# Benchpress Demo Application

This demo application is used to demonstrate the capabilities of Benchpress. It is a simple ASP.NET Core application that has been instrumented with Benchpress. The application is deployed to Azure and then Benchpress is used to run the tests against the application.

## Demo App Files

* [main.bicep](main.bicep) - Bicep module used to deploy the demo application infrastructure
* [deploy-demoapp.ps1](deploy-demoapp.ps1) - PowerShell script used to deploy the infrastructure and the demo application
* [DemoApp.Tests.ps1](DemoApp.Tests.ps1) - PowerShell script used to run the Benchpress tests against the demo application
* [demoapp-pipeline.yml](demoapp-pipeline.yml) - GitHub Action YAML file used to deploy the demo application infrastructure and run the Benchpress tests

## Guidelines for creating and testing a demo application

* Run the [deploy-demoapp.ps1](deploy-demoapp.ps1) script to deploy the demo application infrastructure and the demo application

  * [Application Insights](https://learn.microsoft.com/en-us/azure/azure-monitor/app/app-insights-overview?tabs=net)
  * [Action Group](https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/action-groups)
  * [App Service Plan](https://learn.microsoft.com/en-us/azure/app-service/overview)
  * [Web App](https://azure.microsoft.com/en-us/products/app-service/web)

```powershell
./deploy-demoapp.ps1
```

## Running the tests

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
az group delete --name "benchpress-rg-${env:ENVIRONMENT_SUFFIX}" --yes
```

## Running the deployment, tests, and cleanup together

```powershell
./deploy-demoapp.ps1

./DemoApp.Tests.ps1

az group delete --name "benchpress-rg-${env:ENVIRONMENT_SUFFIX}" --yes
```
