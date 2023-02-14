<#
.DESCRIPTION
  Creates a resource group with given name, location and tags.
#>
function New-ResourceGroup {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory=$true)]
    [string]$Name,
    [Parameter(Mandatory=$true)]
    [string]$Location,
    [Parameter(Mandatory=$true)]
    [string]$Tags
  )

  az group create --name $Name --location $Location --tags $Tags
}

<#
.DESCRIPTION
  Creates a deployment.
#>
function New-Deployment {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroup,
    [Parameter(Mandatory=$true)]
    [string]$TemplateFile,
    [Parameter(Mandatory=$true)]
    [string]$Parameters
  )

  az deployment group create --resource-group $ResourceGroup --template-file $TemplateFile --parameters $Parameters
}

<#
.DESCRIPTION
  Deploys the demo app.
#>

function Deploy-DemoApp {
  [CmdletBinding()]
  param(
    [Switch]$Force,
    [Parameter(Mandatory=$true)]
    [string]$EnvironmentSuffix,
    [Parameter(Mandatory=$true)]
    [string]$Location
  )

  if ($Force -eq $false) {
    Write-Information "This script will create a resource group, a deployment and a web app. If you want to force the execution, use the -Force switch."
    Write-Information ""
    Write-Information "Resources that will be created:"
    Write-Information "  - Resource group: benchpress-rg-${EnvironmentSuffix}"
    Write-Information "  - App Service Plan: benchpress-hosting-plan-${EnvironmentSuffix}"
    Write-Information "  - Web app: benchpress-web-${EnvironmentSuffix}"
    Write-Information "  - Application Insights: benchpress-application-insights-${EnvironmentSuffix}"
    Write-Information "  - Email Action Group: benchpress-email-action-group-${EnvironmentSuffix}"
    Write-Information ""
    return
  }

  New-ResourceGroup -Name "benchpress-rg-${EnvironmentSuffix}" -Location $Location -Tags "application=benchpress-demo suffix=${EnvironmentSuffix}"

  New-Deployment -ResourceGroup "benchpress-rg-${EnvironmentSuffix}" -TemplateFile "main.bicep" -Parameters "suffix=${EnvironmentSuffix}"

  git clone https://github.com/dotnet/AspNetCore.Docs.git

  Push-Location -Path .\AspNetCore.Docs\aspnetcore\mvc\controllers\filters\samples\6.x\FiltersSample

  az webapp up --name "benchpress-web-${EnvironmentSuffix}" --resource-group "benchpress-rg-${EnvironmentSuffix}" --location "${Location}" --sku "F1"

  Pop-Location
}

$ENVIRONMENT_SUFFIX = $env:ENVIRONMENT_SUFFIX ?? (Get-Random).ToString("x8")
$LOCATION = $env:LOCATION ?? "westus2";

Deploy-DemoApp -EnvironmentSuffix $ENVIRONMENT_SUFFIX -Location $LOCATION
