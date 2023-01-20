<#
  .DESCRIPTION
  Invoke an Azure CLI command.

  .SYNOPSIS
  Invoke-AzBPAzCli cmdlet invokes an Azure CLI command and returns the result as an object.

  .EXAMPLE
  PS C:\> Invoke-AzBPAzCli "account list"

  .EXAMPLE
  PS C:\> Invoke-AzBPAzCli "account list --query [].name"

  .EXAMPLE
  PS C:\> Invoke-AzBPAzCli "webapp create --name ${WEBAPP_NAME} --resource-group ${RESOURCE_GROUP_NAME} --plan ${APP_SERVICE_PLAN_NAME}"

  .PARAMETER Command
  The command to execute.

  .NOTES
  Invoke-AzBPAzCli adds the az prefix to the command.

  .LINK
  https://learn.microsoft.com/en-us/cli/azure/

  .LINK
  https://learn.microsoft.com/en-us/cli/azure/get-started-with-azure-cli

  .LINK
  https://learn.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest

  .INPUTS
  System.String

  .OUTPUTS
  System.Object
#>
function Invoke-AzCli {
  [CmdletBinding()]
  [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingInvokeExpression", "")]
  param (
    [Parameter(Mandatory=$true)]
    [string]$Command
  )

  $toExecute = "az $Command"

  $result = Invoke-Expression "$toExecute"

  if ($LastExitCode -gt 0) {
    Write-Error $result
    Exit 1
  }

  $result | ConvertFrom-Json
}

Export-ModuleMember -Function Invoke-AzCli
