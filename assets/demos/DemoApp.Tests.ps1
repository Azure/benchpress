BeforeAll {
  Import-Module "../../BenchPress/Helpers/Azure/BenchPress.Azure.psd1"
}

Describe 'Service Plan Tests' {
  it 'Should contain a service plan with the given name' {
    #arrange
    $rgName = "rg-${env:ENVIRONMENT_NAME}"
    $svcPlanName = "plan-${env:ENVIRONMENT_SUFFIX}"

    #act
    $servicePlan = Get-AzBPAppServicePlan -ResourceGroupName $rgName -AppServicePlanName $svcPlanName

    #assert
    $servicePlan | Should -Not -BeNullOrEmpty
  }
}

Describe 'KeyVault Tests' {
  it 'Should contain a KeyVault with the given name' {
    #arrange
    $rgName = "rg-${env:ENVIRONMENT_NAME}"
    $kvName = "kv-${env:ENVIRONMENT_SUFFIX}"

    #act
    $kv = Get-AzBPKeyVault -ResourceGroupName $rgName -Name $kvName

    #assert
    $kv | Should -Not -BeNullOrEmpty
  }

  it 'Should contain a KeyVault Secret with the given name' {
    #arrange
    $kvName = "kv-${env:ENVIRONMENT_SUFFIX}"
    $secretName = "AZURE-COSMOS-CONNECTION-STRING"

    #act
    $secret = Get-AzBPKeyVaultSecret -KeyVaultName $kvName -Name $secretName

    #assert
    $secret | Should -Not -BeNullOrEmpty
  }
}

Describe 'Web Apps Tests' {
  it 'Should contain an api web app with the given name' {
    #arrange
    $rgName = "rg-${env:ENVIRONMENT_NAME}"
    $webAppName = "app-api-${env:ENVIRONMENT_SUFFIX}"

    #act
    $webApp = Get-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webAppName

    #assert
    $webApp | Should -Not -BeNullOrEmpty
  }

  it 'Should contain an ui web app with the given name' {
    #arrange
    $rgName = "rg-${env:ENVIRONMENT_NAME}"
    $webAppName = "app-web-${env:ENVIRONMENT_SUFFIX}"

    #act
    $webApp = Get-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webAppName

    #assert
    $webApp | Should -Not -BeNullOrEmpty
  }

  it 'Should have the ui web app available' {
    #arrange
    $rgName = "rg-${env:ENVIRONMENT_NAME}"
    $webAppName = "app-web-${env:ENVIRONMENT_SUFFIX}"

    #act
    $webApp = Get-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webAppName

    #assert
    $webApp.AvailabilityState | Should -Be "Normal"
  }

  it 'Should have the api web app https only' {
    #arrange
    $rgName = "rg-${env:ENVIRONMENT_NAME}"
    $webAppName = "app-web-${env:ENVIRONMENT_SUFFIX}"

    #act
    $webApp = Get-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webAppName

    #assert
    $webApp.HttpsOnly | Should -Be $true
  }

  it 'Should contain configuration in the api web app' {
    #arrange
    $rgName = "rg-${env:ENVIRONMENT_NAME}"
    $webAppName = "app-api-${env:ENVIRONMENT_SUFFIX}"

    #act
    $webApp = Get-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webAppName

    #assert
    $webApp.SiteConfig.AppSettings | Should -Not -BeNullOrEmpty
  }

  it 'Should contain application insights configuration in the api web app' {
    #arrange
    $rgName = "rg-${env:ENVIRONMENT_NAME}"
    $webAppName = "app-api-${env:ENVIRONMENT_SUFFIX}"

    #act
    $webApp = Get-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webAppName
    $aiAppSetting = $webApp.SiteConfig.AppSettings | Where-object {$_.Name -eq "APPLICATIONINSIGHTS_CONNECTION_STRING"} | Select-Object -First 1

    #assert
    $aiAppSetting | Should -Not -BeNullOrEmpty
  }
}

Describe 'App is working properly' {
  it 'Should have api endpoint that response with 200 OK' {
    #arrange
    $apiAddress = "https://app-api-${env:ENVIRONMENT_SUFFIX}.azurewebsites.net/lists"

    #act
    $response = Invoke-WebRequest -Uri $apiAddress

    #assert
    $response.StatusCode | Should -Be 200
  }

  it 'Should have todo list api endpoint that returns the name of the list' {
    #arrange
    $apiAddress = "https://app-api-${env:ENVIRONMENT_SUFFIX}.azurewebsites.net/lists"

    #act
    $response = Invoke-WebRequest -Uri $apiAddress
    $json = $response.Content | ConvertFrom-Json

    #assert
    $json.name | Should -Be "My List"
  }

  it 'Should have ui endpoint that response with 200 OK' {
    #arrange
    $apiAddress = "https://app-web-${env:ENVIRONMENT_SUFFIX}.azurewebsites.net/lists"

    #act
    $response = Invoke-WebRequest -Uri $apiAddress

    #assert
    $response.StatusCode | Should -Be 200
  }
}
