<#
  .SYNOPSIS
    Confirm-BicepFile will confirm that the bicep files provided pass the checks executed by `bicep build`.

  .DESCRIPTION
    Confirm-BicepFile executes `bicep build` and returns an object that has an array field BicepErrors. Each element of
    this array is an object that contains the bicep file path that had errors and a collection of
    System.Object.ErrorRecord that correspond to the file at that path:

    {BicepErrors: [
        {Path: [string], ErrorResults: [ErrorRecord[]]}, {Path: [string], ErrorResults: [ErrorRecord[]]}, ...
      ]}

    Any errors will also be output to stdout for capture by CI/CD pipelines.

  .PARAMETER BicepPath
    This is the path to the bicep file that will be confirmed.
    BicepPath is a mandatory parameter.
    The property name is optional if the path is provided as the first argument to Confirm-BicepFile.

  .EXAMPLE
    ---------- Example 1: Pipe path into Confirm-BicepFile ----------

    "./examples/actionGroupErrors.bicep" | Confirm-BicepFile

    Confirm-BicepFile: ../../../examples/actionGroupErrors.bicep:
    Confirm-BicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(6,7) : Warning no-unused-params: Parameter "location" is declared but never used. [https://aka.ms/bicep/linter/no-unused-params]
    Confirm-BicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(12,13) : Warning no-hardcoded-location: A resource location should not use a hard-coded string or variable value. Please use a parameter value, an expression, or the string 'global'. Found: 'westus' [https://aka.ms/bicep/linter/no-hardcoded-location]
    0

    BicepErrors
    -----------
    {@{Path=../../../examples/actionGroupErrors.bicep; ErrorResults=System.Collections.ObjectModel.Collection`1[System.Management.Automation.PSObject]…

    ---------- Example 2: Pipe multiple paths into Confirm-BicepFile ----------

    "./examples/actionGroupErrors.bicep", "./examples/actionGroupErrors.bicep" | Confirm-BicepFile

    Confirm-BicepFile: ../../../examples/actionGroupErrors.bicep:
    Confirm-BicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(6,7) : Warning no-unused-params: Parameter "location" is declared but never used. [https://aka.ms/bicep/linter/no-unused-params]
    Confirm-BicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(12,13) : Warning no-hardcoded-location: A resource location should not use a hard-coded string or variable value. Please use a parameter value, an expression, or the string 'global'. Found: 'westus' [https://aka.ms/bicep/linter/no-hardcoded-location]
    0
    Confirm-BicepFile: ../../../examples/actionGroupErrors.bicep:
    Confirm-BicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(6,7) : Warning no-unused-params: Parameter "location" is declared but never used. [https://aka.ms/bicep/linter/no-unused-params]
    Confirm-BicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(12,13) : Warning no-hardcoded-location: A resource location should not use a hard-coded string or variable value. Please use a parameter value, an expression, or the string 'global'. Found: 'westus' [https://aka.ms/bicep/linter/no-hardcoded-location]
    1

    BicepErrors
    -----------
    {@{Path=../../../examples/actionGroupErrors.bicep; ErrorResults=System.Collections.ObjectModel.Collection`1[System.Management.Automation.PSObject]…

    ---------- Example 3: Provide -BicepPath Parameter ----------

    Confirm-BicepFile -BicepPath ./examples/actionGroupErrors.bicep

    Confirm-BicepFile: ../../../examples/actionGroupErrors.bicep:
    Confirm-BicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(6,7) : Warning no-unused-params: Parameter "location" is declared but never used. [https://aka.ms/bicep/linter/no-unused-params]
    Confirm-BicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(12,13) : Warning no-hardcoded-location: A resource location should not use a hard-coded string or variable value. Please use a parameter value, an expression, or the string 'global'. Found: 'westus' [https://aka.ms/bicep/linter/no-hardcoded-location]
    0

    BicepErrors
    -----------
    {@{Path=../../../examples/actionGroupErrors.bicep; ErrorResults=System.Collections.ObjectModel.Collection`1[System.Management.Automation.PSObject]…

    ---------- Example 4: Path without -BicepPath Parameter ----------

    Confirm-BicepFile ./examples/actionGroupErrors.bicep

    Confirm-BicepFile: ../../../examples/actionGroupErrors.bicep:
    Confirm-BicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(6,7) : Warning no-unused-params: Parameter "location" is declared but never used. [https://aka.ms/bicep/linter/no-unused-params]
    Confirm-BicepFile: /workspaces/benchpress/examples/actionGroupErrors.bicep(12,13) : Warning no-hardcoded-location: A resource location should not use a hard-coded string or variable value. Please use a parameter value, an expression, or the string 'global'. Found: 'westus' [https://aka.ms/bicep/linter/no-hardcoded-location]
    0

    BicepErrors
    -----------
    {@{Path=../../../examples/actionGroupErrors.bicep; ErrorResults=System.Collections.ObjectModel.Collection`1[System.Management.Automation.PSObject]…

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
      BicepErrors = New-Object System.Collections.ArrayList
    }
  }
  Process {
    foreach ($path in $BicepFilePath) {
      # The --stdout parameter will send the built ARM template to stdout instead of creating a file
      # 2>&1 will send errors to stdout so that they can be captured by PowerShell
      # Both the ARM template and any output from linting will be in the array $results, with individual errors in the
      # array separately
      $results = Invoke-Command -ScriptBlock {bicep build $path --stdout 2>&1}
      # .Where() returns a collection of System.Object.ErrorRecord or null if there are no errors
      $errorResults = $results.Where({$PSItem.GetType().Name -eq 'ErrorRecord'})

      if ($errorResults.Count -gt 0) {
        Write-Error "${path}:"
        $errorResults | Write-Error

        $out.BicepErrors.Add([PSCustomObject]@{Path = $path; ErrorResults = $errorResults})
      }
    }
  }
  End {
    return $out
  }
}

function Deploy-BicepFeature([string]$path, $params, $resourceGroupName){
  $fileName = [System.IO.Path]::GetFileNameWithoutExtension($path)
  $folder = Split-Path $path
  $armPath  = Join-Path -Path $folder -ChildPath "$fileName.json"

  Write-Information "Transpiling Bicep to Arm"
  az bicep build --file $path

  $code = $?
  if ($code -eq "True") {
    $location = $params.location
    $deploymentName = $params.deploymentName

    if ([string]::IsNullOrEmpty($deploymentName)) {
      $deploymentName = "BenchPressDeployment"
    }

    Write-Information "Deploying ARM Template ($deploymentName) to $location"

    if ([string]::IsNullOrEmpty($resourceGroupName)) {
      New-AzSubscriptionDeployment -Name "$deploymentName" -Location "$location" -TemplateFile "$armPath" -TemplateParameterObject $params -SkipTemplateParameterPrompt
    }
    else{
      New-AzResourceGroupDeployment -Name "$deploymentName" -ResourceGroupName "$resourceGroupName" -TemplateFile "$armPath" -TemplateParameterObject $params -SkipTemplateParameterPrompt
    }
  }

  Write-Information "Removing Arm template json"
  Remove-Item "$armPath"
}

function Remove-BicepFeature($resourceGroupName){
  Get-AzResourceGroup -Name $resourceGroupName | Remove-AzResourceGroup -Force
}

Export-ModuleMember -Function Confirm-BicepFile, Deploy-BicepFeature, Remove-BicepFeature
