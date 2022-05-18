function Deploy-BicepFeature([string]$path, $params){
    bicep build $path
    $code = $?
    if ($code -eq "True"){ # arm deployment was successful
        New-AzSubscriptionDeployment -Location $params.location -TemplateFile examples/main.json -TemplateParameterObject $params
    }
}

function Remove-BicepFeature($params){
    Get-AzResourceGroup -Name $params.name | Remove-AzResourceGroup -Force
}