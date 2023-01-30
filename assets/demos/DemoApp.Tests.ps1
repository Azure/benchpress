BeforeAll {
  Import-Module "../../BenchPress/Helpers/Azure/BenchPress.Azure.psd1"
}

Describe 'Resource Group Tests' {
  it 'Should contain a resource group with the given name' {
    #arrange
    $rgName = "benchpress-rg-${env:ENVIRONMENT_SUFFIX}"

    #act
    $resourceGroup = Get-AzBPResourceGroup -ResourceGroupName $rgName

    #assert
    $resourceGroup | Should -Not -BeNullOrEmpty
  }
}

Describe 'Service Plan Tests' {
  it 'Should contain a service plan with the given name' {
    #arrange
    $rgName = "benchpress-rg-${env:ENVIRONMENT_SUFFIX}"
    $svcPlanName = "benchpress-hosting-plan-${env:ENVIRONMENT_SUFFIX}"

    #act
    $servicePlan = Get-AzBPAppServicePlan -ResourceGroupName $rgName -AppServicePlanName $svcPlanName

    #assert
    $servicePlan | Should -Not -BeNullOrEmpty
  }
}

Describe 'Action Group Tests' {
  it 'Should contain an email action group with the given name' {
    #arrange
    $rgName = "benchpress-rg-${env:ENVIRONMENT_SUFFIX}"
    $agName = "benchpress-email-action-group-${env:ENVIRONMENT_SUFFIX}"

    #act
    $ag = Get-AzBPActionGroup -ResourceGroupName $rgName -ActionGroupName $agName

    #assert
    $ag | Should -Not -BeNullOrEmpty
  }
}

Describe 'Web Apps Tests' {
  it 'Should contain a web app with the given name' {
    #arrange
    $rgName = "benchpress-rg-${env:ENVIRONMENT_SUFFIX}"
    $webAppName = "benchpress-web-${env:ENVIRONMENT_SUFFIX}"

    #act
    $webApp = Get-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webAppName

    #assert
    $webApp | Should -Not -BeNullOrEmpty
  }

  it 'Should have the web app availability state as normal' {
    #arrange
    $rgName = "benchpress-rg-${env:ENVIRONMENT_SUFFIX}"
    $webAppName = "benchpress-web-${env:ENVIRONMENT_SUFFIX}"

    #act
    $webApp = Get-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webAppName

    #assert
    $webApp.AvailabilityState | Should -Be "Normal"
  }

  it 'Should have the web app works https only' {
    #arrange
    $rgName = "benchpress-rg-${env:ENVIRONMENT_SUFFIX}"
    $webAppName = "benchpress-web-${env:ENVIRONMENT_SUFFIX}"

    #act
    $webApp = Get-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webAppName

    #assert
    $webApp.HttpsOnly | Should -Be $true
  }

  it 'Should contain configuration in the web app' {
    #arrange
    $rgName = "benchpress-rg-${env:ENVIRONMENT_SUFFIX}"
    $webAppName = "benchpress-web-${env:ENVIRONMENT_SUFFIX}"

    #act
    $webApp = Get-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webAppName

    #assert
    $webApp.SiteConfig.AppSettings | Should -Not -BeNullOrEmpty
  }

  it 'Should contain application insights configuration in the web app' {
    #arrange
    $rgName = "benchpress-rg-${env:ENVIRONMENT_SUFFIX}"
    $webAppName = "benchpress-web-${env:ENVIRONMENT_SUFFIX}"

    #act
    $webApp = Get-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webAppName
    $aiAppSetting = $webApp.SiteConfig.AppSettings | Where-object {$_.Name -eq "APPLICATIONINSIGHTS_CONNECTION_STRING"} | Select-Object -First 1

    #assert
    $aiAppSetting | Should -Not -BeNullOrEmpty
  }
}

Describe 'App is working properly' {
  it 'Should have root endpoint that response with 200 OK' {
    #arrange
    $apiAddress = "https://benchpress-web-${env:ENVIRONMENT_SUFFIX}.azurewebsites.net/"

    #act
    $response = Invoke-WebRequest -Uri $apiAddress

    #assert
    $response.StatusCode | Should -Be 200
  }
}
