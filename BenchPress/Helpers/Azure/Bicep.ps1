function Deploy-BicepFeature([string]$path, $params) {
  bicep build $path
  $code = $?
  if ($code -eq "True") {
    New-AzSubscriptionDeployment -Location $params.location -TemplateFile examples/main.json -TemplateParameterObject $params
  }
}

function Remove-BicepFeature($params) {
  Get-AzResourceGroup -Name $params.name | Remove-AzResourceGroup -Force
}
