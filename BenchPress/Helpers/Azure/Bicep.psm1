# Bicep Feature receives three parameters.
# 1. Bicep file path. 2. parameters 3. resourceGroupName

function Deploy-BicepFeature([string]$path, $params){
  # armPath will be assigned for same bicep file name with json extension
  $fileName = [System.IO.Path]::GetFileNameWithoutExtension($path)
  $folder = Split-Path $path
  $armPath  = Join-Path -Path $folder -ChildPath "$fileName.json"

  # az bicep build will create arm template from bicep file.
  # Arm template will same as bicep name with json extension
  Write-Host "Transpiling Bicep to Arm"
  az bicep build --file $path

  $code = $?
  if ($code -eq "True") {
    $location = $params.location
    $deploymentName = $params.resourceGroupName
    # TODO: Bicep code deploys using subscription deployment. Required to add other deployment types
    # 1. TenantDeployment 2.ResourceGroupDeployment 3. ManagementGroupDeployment 4. SubscriptionDeployment
    New-AzSubscriptionDeployment -Name "$deploymentName" -Location "$location" -TemplateFile "$armPath" -TemplateParameterObject $params -SkipTemplateParameterPrompt

  Write-Host "Removing Arm template json"
  Remove-Item "$armPath"
}

function Remove-BicepFeature($resourceGroupName){
  Get-AzResourceGroup -Name $resourceGroupName | Remove-AzResourceGroup -Force
}

Export-ModuleMember -Function Deploy-BicepFeature, Remove-BicepFeature
