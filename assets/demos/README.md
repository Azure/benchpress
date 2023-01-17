# Benchpress Demo Application

ToDo Application with a Node.js API and Azure Cosmos DB API for MongoDB on Azure App Service

A complete ToDo application that includes everything you need to build, deploy, and monitor an Azure solution. This application uses the Azure Developer CLI (azd) to get you up and running on Azure quickly using Bicep as the IaC provider, React.js for the Web application, Node.js for the API, Azure Cosmos DB API for MongoDB for storage, and Azure Monitor for monitoring and logging. It includes application code, tools, and pipelines that serve as a foundation from which you can build upon and customize when creating your own solutions.

You can use this project to deploy a simple demo application to your Azure Subscription and run tests, using BenchPress.

## Prerequisites

* [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest)
* [Azure Developer CLI](https://learn.microsoft.com/en-us/azure/developer/azure-developer-cli/install-azd)
* [Node.js](https://nodejs.org/en/download/)

## Install ToDo NodeJs MongoDB project template

- Login to Azure

```powershell
azd login
```

- In an empty folder create the project by executing azd init command with the following parameters:
  * --template: The name of the template to use
  * --environment: The name of the environment to use, like, `benchpress-demo`
  * --location: The location to use
  * --subscription: The subscription to use

```powershell
azd init --template todo-nodejs-mongo --environment <environment_name> --location <location> --subscription <subscription-id>
```

## Deploying the demo application to Azure

- Run azd up command to deploy the application

```powershell
azd up
```

## Running the demo application locally

- Go to ./src/api folder

```powershell
cd ./src/api
```

- Install the dependencies

```powershell
npm install
```

- Run the application

```powershell
npm run start
```

- Go to ./src/web folder

```powershell
cd ./src/web
```

- Install the dependencies

```powershell
npm install
```

- Run the application

```powershell
npm run start
```

## Running the tests

- Setup the environment variables

```powershell
$env:ENVIRONMENT_NAME = "<environment_name>" # The name of the environment to use, like, `benchpress-demo
$env:ENVIRONMENT_SUFFIX = "<environment_suffix>" # Can be retrieved from the output of azd command, or `azure/<environment_name>/.env` file, like, `aiqqogaekwzue`

- Run the tests by calling the test script file, or, `Invoke-Pester` command

```powershell
./DemoApp.Tests.ps1
```

```powershell
Invoke-Pester
```

## Cleaning up the demo application

- Delete the resource group

```powershell
azd down
```
