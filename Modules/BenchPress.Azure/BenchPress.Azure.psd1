﻿# Module manifest for module "BenchPress.Azure"
# Generated by: CSEDevOps
# Generated on: 12/1/2022
@{
  RootModule           = "BenchPress.Azure.psm1"
  ModuleVersion        = "0.2.3"
  GUID                 = "3db0c6b2-7453-4972-a9de-402be1277ac9"
  Author               = "CSEDevOps"
  CompanyName          = "Microsoft"
  Copyright            = "(c) Microsoft. All rights reserved."
  Description          = "Benchpress Test Framework for Azure Deployment Scenarios"
  NestedModules        = @()
  FunctionsToExport    = @(
    "Confirm-Account",
    "Confirm-ActionGroup",
    "Confirm-AksCluster",
    "Confirm-AksNodePool",
    "Confirm-ApiManagement",
    "Confirm-ApiManagementApi",
    "Confirm-ApiManagementDiagnostic",
    "Confirm-ApiManagementLogger",
    "Confirm-ApiManagementPolicy",
    "Confirm-AppInsights",
    "Confirm-AppServicePlan",
    "Confirm-BicepFile",
    "Confirm-ContainerApp",
    "Confirm-ContainerAppManagedEnv",
    "Confirm-ContainerRegistry",
    "Confirm-CosmosDBAccount",
    "Confirm-CosmosDBGremlinDatabase",
    "Confirm-CosmosDBMongoDBDatabase",
    "Confirm-CosmosDBSqlDatabase",
    "Confirm-CosmosDBSqlRoleAssignment",
    "Confirm-CosmosDBSqlRoleDefinition",
    "Confirm-DataFactory",
    "Confirm-DataFactoryLinkedService",
    "Confirm-DiagnosticSetting",
    "Confirm-EventHub",
    "Confirm-EventHubConsumerGroup",
    "Confirm-EventHubNamespace",
    "Confirm-KeyVault",
    "Confirm-KeyVaultCertificate",
    "Confirm-KeyVaultKey",
    "Confirm-KeyVaultSecret",
    "Confirm-OperationalInsightsWorkspace",
    "Confirm-PortalDashboard",
    "Confirm-PostgreSqlFlexibleServer",
    "Confirm-Resource",
    "Confirm-ResourceGroup",
    "Confirm-RoleAssignment",
    "Confirm-SearchService",
    "Confirm-SqlDatabase",
    "Confirm-SqlServer",
    "Confirm-StorageAccount",
    "Confirm-StorageContainer",
    "Confirm-StreamAnalyticsCluster",
    "Confirm-StreamAnalyticsFunction",
    "Confirm-StreamAnalyticsInput",
    "Confirm-StreamAnalyticsJob",
    "Confirm-StreamAnalyticsOutput",
    "Confirm-StreamAnalyticsTransformation",
    "Confirm-SynapseSparkPool",
    "Confirm-SynapseSqlPool",
    "Confirm-SynapseWorkspace",
    "Confirm-VirtualMachine",
    "Confirm-WebApp",
    "Confirm-WebAppStaticSite",
    "Deploy-BicepFeature",
    "Get-Resource",
    "Get-ResourceByType",
    "Invoke-AzCli",
    "Remove-BicepFeature",
    "ShouldBeSuccessful",
    "ShouldBeInLocation",
    "ShouldBeInResourceGroup"
  )
  PrivateData          = @{
    PSData = @{
      Tags                     = @("Azure", "BenchPress", "Bicep", "ARM", "Test", "ActionGroup", "AKS", "AksCluster", "ContainerRegistry", "KeyVault", "ResourceGroup", "ServicePlan", "SqlDatabase", "SqlServer", "StorageAccount", "VirtualMachine", "WebApp")
      LicenseUri               = ""
      ProjectUri               = "https://github.com/Azure/benchpress/"
      IconUri                  = ""
      ReleaseNotes             = ""
      Prerelease               = ""
      RequireLicenseAcceptance = $false
    }
  }
  HelpInfoURI          = "https://github.com/Azure/benchpress/"
  DefaultCommandPrefix = "AzBP"
}
