az group create --name "benchpress-rg-${env:ENVIRONMENT_SUFFIX}" --location "${env:LOCATION}"

az deployment group create --resource-group "benchpress-rg-${env:ENVIRONMENT_SUFFIX}" --template-file "main.bicep" --parameters suffix="${env:ENVIRONMENT_SUFFIX}"

git clone https://github.com/dotnet/AspNetCore.Docs.git

Push-Location -Path .\AspNetCore.Docs\aspnetcore\mvc\controllers\filters\samples\6.x\FiltersSample

az webapp up --name "benchpress-web-${env:ENVIRONMENT_SUFFIX}" --resource-group "benchpress-rg-${env:ENVIRONMENT_SUFFIX}" --location "${env:LOCATION}" --sku "F1"

Pop-Location
