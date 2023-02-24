using module ./../Classes/ConfirmResult.psm1

function Deploy-BicepFeature(){
  <#
    .SYNOPSIS
      Deploys Azure resources using a bicep file.

    .DESCRIPTION
      Deploy-AzBPBicepFeature cmdlet deploys Azure resources when given a path to a bicep file. The cmdlet will
      transpile the bicep file to an ARM template and uses the ARM template to deploy to Azure.

    .PARAMETER BicepPath
      This is the path to the bicep file that will be used to transpile to ARM and deploy to Azure.

    .EXAMPLE
      $params = @{
        name           = "acrbenchpresstest1"
        location       = "westus3"
      }
      Deploy-AzBPBicepFeature -BicepPath "./containerRegistry.bicep" -Params $params -ResourceGroupName "rg-test"

    .INPUTS
      System.String
      System.Collections.Hashtable

    .OUTPUTS
      None
  #>
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true)]
    [string]$BicepPath,

    [Parameter(Mandatory=$true)]
    [hashtable]$Params,

    [Parameter(Mandatory=$false)]
    [string]$ResourceGroupName
  )
  $fileName = [System.IO.Path]::GetFileNameWithoutExtension($BicepPath)
  $folder = Split-Path $BicepPath
  $armPath  = Join-Path -Path $folder -ChildPath "$fileName.json"

  Connect-Account

  Write-Information "Transpiling Bicep to Arm"
  # 2>&1 will send errors to stdout so that they can be captured by PowerShell
  # Both the ARM template and any output from linting will be in the array $results, with individual errors in the
  # array separately
  $results = Invoke-Command -ScriptBlock { bicep build $BicepPath 2>&1 }
  # .Where() returns a collection of System.Management.Automation.ErrorRecord or null if there are no errors
  $errorResults = $results.Where({$PSItem.GetType().Name -eq 'ErrorRecord'})

  # Only deploy if there are no errors.
  if ($errorResults.Count -eq 0) {
    $location = $Params.location
    $deploymentName = $Params.deploymentName

    if ([string]::IsNullOrEmpty($deploymentName)) {
      $deploymentName = "BenchPressDeployment"
    }

    Write-Information "Deploying ARM Template ($deploymentName) to $location"

    if ([string]::IsNullOrEmpty($ResourceGroupName)) {
      New-AzSubscriptionDeployment -Name "$deploymentName" -Location "$location" -TemplateFile "$armPath" -TemplateParameterObject $Params -SkipTemplateParameterPrompt
    }
    else{
      New-AzResourceGroupDeployment -Name "$deploymentName" -ResourceGroupName "$ResourceGroupName" -TemplateFile "$armPath" -TemplateParameterObject $Params -SkipTemplateParameterPrompt
    }
  }

  Write-Information "Removing Arm template json"
  Remove-Item "$armPath"
}
