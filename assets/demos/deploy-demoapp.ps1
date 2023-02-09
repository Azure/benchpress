$ENVIRONMENT_SUFFIX = $env:ENVIRONMENT_SUFFIX ?? "benchpress-rg-$((Get-Random).ToString("x8"))";
$LOCATION = $env:LOCATION ?? "westus2";

az group create --name "benchpress-rg-${ENVIRONMENT_SUFFIX}" --location "${LOCATION}"

az deployment group create --resource-group "benchpress-rg-${ENVIRONMENT_SUFFIX}" --template-file "main.bicep" --parameters suffix="${ENVIRONMENT_SUFFIX}"

git clone https://github.com/dotnet/AspNetCore.Docs.git

Push-Location -Path .\AspNetCore.Docs\aspnetcore\mvc\controllers\filters\samples\6.x\FiltersSample

az webapp up --name "benchpress-web-${ENVIRONMENT_SUFFIX}" --resource-group "benchpress-rg-${ENVIRONMENT_SUFFIX}" --location "${LOCATION}" --sku "F1"

Pop-Location
