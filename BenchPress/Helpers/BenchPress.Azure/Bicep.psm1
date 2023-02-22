Import-Module $PSScriptRoot/Authentication.psm1

<#
  .SYNOPSIS
    Confirm-AzBPBicepFile will confirm that the bicep files provided pass the checks executed by `bicep build`.

  .DESCRIPTION
    Confirm-AzBPBicepFile executes `bicep build` and returns an object that has an array field Errors. Each element of
    this array is an object that contains the bicep file path that had errors and a collection of
    System.Object.ErrorRecord that correspond to the file at that path:

    {Errors: [
        {Path: [string], ErrorResults: [ErrorRecord[]]}, {Path: [string], ErrorResults: [ErrorRecord[]]}, ...
      ]}

    Any errors will also be output to stdout for capture by CI/CD pipelines.

  .PARAMETER BicepPath
    This is the path to the bicep file that will be confirmed.
    BicepPath is a mandatory parameter.
    The property name is optional if the path is provided as the first argument to Confirm-AzBPBicepFile.

  .EXAMPLE
    Pipe path into Confirm-AzBPBicepFile

    "./examples/actionGroupErrors.bicep" | Confirm-AzBPBicepFile

    Confirm-AzBPBicepFile: ../../../examples/actionGroupErrors.bicep:
    Confirm-AzBPBicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(6,7) : Warning no-unused-params: Parameter "location" is declared but never used. [https://aka.ms/bicep/linter/no-unused-params]
    Confirm-AzBPBicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(12,13) : Warning no-hardcoded-location: A resource location should not use a hard-coded string or variable value. Please use a parameter value, an expression, or the string 'global'. Found: 'westus' [https://aka.ms/bicep/linter/no-hardcoded-location]
    0

    Errors
    -----------
    {@{Path=../../../examples/actionGroupErrors.bicep; ErrorResults=System.Collections.ObjectModel.Collection`1[System.Management.Automation.PSObject]...

  .EXAMPLE
    Pipe multiple paths into Confirm-AzBPBicepFile

    "./examples/actionGroupErrors.bicep", "./examples/actionGroupErrors.bicep" | Confirm-AzBPBicepFile

    Confirm-AzBPBicepFile: ../../../examples/actionGroupErrors.bicep:
    Confirm-AzBPBicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(6,7) : Warning no-unused-params: Parameter "location" is declared but never used. [https://aka.ms/bicep/linter/no-unused-params]
    Confirm-AzBPBicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(12,13) : Warning no-hardcoded-location: A resource location should not use a hard-coded string or variable value. Please use a parameter value, an expression, or the string 'global'. Found: 'westus' [https://aka.ms/bicep/linter/no-hardcoded-location]
    0
    Confirm-AzBPBicepFile: ../../../examples/actionGroupErrors.bicep:
    Confirm-AzBPBicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(6,7) : Warning no-unused-params: Parameter "location" is declared but never used. [https://aka.ms/bicep/linter/no-unused-params]
    Confirm-AzBPBicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(12,13) : Warning no-hardcoded-location: A resource location should not use a hard-coded string or variable value. Please use a parameter value, an expression, or the string 'global'. Found: 'westus' [https://aka.ms/bicep/linter/no-hardcoded-location]
    1

    Errors
    -----------
    {@{Path=../../../examples/actionGroupErrors.bicep; ErrorResults=System.Collections.ObjectModel.Collection`1[System.Management.Automation.PSObject]...

  .EXAMPLE
    Provide -BicepPath Parameter

    Confirm-AzBPBicepFile -BicepPath ./examples/actionGroupErrors.bicep

    Confirm-AzBPBicepFile: ../../../examples/actionGroupErrors.bicep:
    Confirm-AzBPBicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(6,7) : Warning no-unused-params: Parameter "location" is declared but never used. [https://aka.ms/bicep/linter/no-unused-params]
    Confirm-AzBPBicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(12,13) : Warning no-hardcoded-location: A resource location should not use a hard-coded string or variable value. Please use a parameter value, an expression, or the string 'global'. Found: 'westus' [https://aka.ms/bicep/linter/no-hardcoded-location]
    0

    Errors
    -----------
    {@{Path=../../../examples/actionGroupErrors.bicep; ErrorResults=System.Collections.ObjectModel.Collection`1[System.Management.Automation.PSObject]...

  .EXAMPLE
      Path without -BicepPath Parameter

    Confirm-AzBPBicepFile ./examples/actionGroupErrors.bicep

    Confirm-AzBPBicepFile: ../../../examples/actionGroupErrors.bicep:
    Confirm-AzBPBicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(6,7) : Warning no-unused-params: Parameter "location" is declared but never used. [https://aka.ms/bicep/linter/no-unused-params]
    Confirm-AzBPBicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(12,13) : Warning no-hardcoded-location: A resource location should not use a hard-coded string or variable value. Please use a parameter value, an expression, or the string 'global'. Found: 'westus' [https://aka.ms/bicep/linter/no-hardcoded-location]
    0

    Errors
    -----------
    {@{Path=../../../examples/actionGroupErrors.bicep; ErrorResults=System.Collections.ObjectModel.Collection`1[System.Management.Automation.PSObject]...

  .INPUTS
    System.String[]

  .OUTPUTS
    System.Management.Automation.PSCustomObject[]
#>
function Confirm-BicepFile {
  [CmdletBinding()]
  [OutputType([System.Object[]])]
  param(
    [Parameter(Mandatory, Position=0, ValueFromPipeline)] [string[]]$BicepFilePath
  )
  Begin{
    $out = [PSCustomObject]@{
      Errors = New-Object System.Collections.ArrayList
    }
  }
  Process {
    foreach ($path in $BicepFilePath) {
      # The --stdout parameter will send the built ARM template to stdout instead of creating a file
      # 2>&1 will send errors to stdout so that they can be captured by PowerShell
      # Both the ARM template and any output from linting will be in the array $results, with individual errors in the
      # array separately
      $results = Invoke-Command -ScriptBlock { bicep build $path --stdout 2>&1 }
      # .Where() returns a collection of System.Management.Automation.ErrorRecord or null if there are no errors
      $errorResults = $results.Where({$PSItem.GetType().Name -eq 'ErrorRecord'})

      if ($errorResults.Count -gt 0) {
        Write-Error "${path}:"
        $errorResults | Write-Error

        $out.Errors.Add([PSCustomObject]@{Path = $path; ErrorResults = $errorResults})
      }
    }
  }
  End {
    return $out
  }
}

<#
  .SYNOPSIS
    Deploys Azure resources using a bicep file.

  .DESCRIPTION
    Deploy-AzBPBicepFeature cmdlet deploys Azure resources when given a path to a bicep file. The cmdlet will transpile the
    bicep file to an ARM template and uses the ARM template to deploy to Azure.

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
function Deploy-BicepFeature(){
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

<#
  .SYNOPSIS
    Deletes Azure resources.

  .DESCRIPTION
    Remove-AzBPBicepFeature cmdlet will take an Azure Resource Group name and delete that resource group and all
    resources contained in it.

  .PARAMETER ResourceGroupName
    Name of the Resource Group to delete

  .EXAMPLE
    Remove-AzBPBicepFeature -ResourceGroupName "rg-test"

  .INPUTS
    System.String

  .OUTPUTS
    None
#>
function Remove-BicepFeature(){
  [CmdletBinding()]
  [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions", "")]
  param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
  )

  Connect-Account

  $resourceGroup = Get-AzResourceGroup -Name $ResourceGroupName
  Remove-AzResourceGroup -Name $resourceGroup -Force
}

Export-ModuleMember -Function Confirm-BicepFile, Deploy-BicepFeature, Remove-BicepFeature
