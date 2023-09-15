# Contributing Modules

BenchPress is designed to be extensible. You can create your own modules and contribute them to the community.

## Module Structure

A valid module must have these files;

```text
Modules/BenchPress.Azure/Public
└───Confirm-{Resource Type Name}.ps1

Modules/BenchPress.Azure/Tests/Public
└───Confirm-{Resource Type Name}.Tests.ps1

examples/{Resource Type Name}
├───{Resource Type Name}.Tests.ps1
├───{Resource Type Name}.bicep
└───{Resource Type Name}_Example.md
```

## Module Development

- Create a new module with the required files mentioned above.

- Add `Confirm-{Resource Type Name}` function to the [Modules/BenchPress.Azure/BenchPress.Azure.psd1](../Modules/BenchPress.Azure/BenchPress.Azure.psd1) file in the alphabetical order.

- Add `{Resource Type Name}` to the [Modules/BenchPress.Azure/Classes/ResourceType.psm1](../Modules/BenchPress.Azure/Classes/ResourceType.psm1) file in the alphabetical order.

- Add `. $PSScriptRoot/Confirm-{Resource Type Name}.ps1` to the beginning of the [Modules/BenchPress.Azure/Public/Get-ResourceByType.ps1](../Modules/BenchPress.Azure/Public/Get-ResourceByType.ps1) file in the alphabetical order.

- Add a section for the new resource type to the end of the [Modules/BenchPress.Azure/Public/Get-ResourceByType.ps1](../Modules/BenchPress.Azure/Public/Get-ResourceByType.ps1) file in the alphabetical order, such as;

```powershell
"{Resource Type Name}" {
  return Confirm-{Resource Type Name} -ResourceGroupName $ResourceGroupName -Name $ResourceName
}
```

## Module Testing

- Run the following command in the root directory of the project to create local copy of the BenchPress in the `bin` folder;

```powershell
.\build.ps1 -Inline
```

- Replace the `BeforeAll` section of the `examples/{Resource Type Name}/{Resource Type Name}.Tests.ps1` file with the following code;

```powershell
# old
Import-Module Az.InfrastructureTesting

# new
Import-Module ../../bin/BenchPress.Azure.psd1
```

- Run this command to and create a new service principal and store the credentials in a variable;

```powershell
$AZURE_RBAC = $(az ad sp create-for-rbac --name "BenchPress.Module.Contributor" --role contributor --scopes /subscriptions/$(az account show --query "id" --output "tsv"))
```

- Set the following environment variables;

```powershell
$env:AZ_SUBSCRIPTION_ID = "$(az account show --query 'id' --output tsv)"
$env:AZ_TENANT_ID = "$(az account show --query 'tenantId' --output tsv)"
$env:AZ_APPLICATION_ID = $($AZURE_RBAC | ConvertFrom-Json).appId
$env:AZ_ENCRYPTED_PASSWORD = $($AZURE_RBAC | ConvertFrom-Json).password | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString
```

- Run the following command to run the tests;

```powershell
Invoke-Pester -Script examples/{Resource Type Name}/{Resource Type Name}.Tests.ps1
```

- Run the following command to remove the service principal;

## Cleanup

```powershell
az ad sp delete --id $($AZURE_RBAC | ConvertFrom-Json).appId
```

## Module Publishing

- If local tests are successful, replace the `BeforeAll` section of the `examples/{Resource Type Name}/{Resource Type Name}.Tests.ps1` file with the following code;

```powershell
# old
Import-Module ../../bin/BenchPress.Azure.psd1

# new
Import-Module Az.InfrastructureTesting
```

- Create a PR on the [BenchPress](https://github.com/azure/benchpress) repository. BenchPress Maintainers team will review the PR and merge it.

## What if the resource type is not in the Azure PowerShell module?

If the resource type is not in the Core Azure PowerShell module (`Az`), you have to do the following steps;

- Find the module that contains the resource type. For example, `Az.Portal` module contains `Azure Dashboard` resource type.

- Add the module installer to [ci.yml](../.github/workflows/ci.yml) file.

```yml
Install-Module -Name Az.{ModuleName} -Scope CurrentUser -Repository PSGallery -Force
```

- Add the module installer to [pr-powershell.yml](../.github/workflows/pr-powershell.yml) file too.

```yml
Install-Module Az.{ModuleName} -ErrorAction Stop
```

- Add the module importer to the beginning of the `Modules/BenchPress.Azure/Public/Confirm-{Resource Type Name}.ps1` file;

```powershell
Import-Module Az.{ModuleName}
```

- Add the module importer to the beginning of the `Modules/BenchPress.Azure/Tests/Public/Confirm-{Resource Type Name}.Tests.ps1` file;

```powershell
Import-Module Az.{ModuleName}
```
