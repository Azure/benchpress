BeforeAll {
  Import-Module "../../bin/BenchPress.Azure.psd1"

  $Script:rgName = "benchpress-rg-${env:ENVIRONMENT_SUFFIX}"
  $Script:webAppName = "benchpress-web-${env:ENVIRONMENT_SUFFIX}"
}

Describe 'Resource Group Tests' {
  it 'Should contain a resource group with the given name' {
    #arrange
    $params = @{
      ResourceType = 'ResourceGroup'
      ResourceName = $rgName
    }

    #act
    $resourceGroup = Confirm-AzBPResource @params

    #assert
    $resourceGroup.Success | Should -BeTrue
  }
}

Describe 'Service Plan Tests' {
  it 'Should contain a service plan with the given name' {
    #arrange
    $svcPlanName = "benchpress-hosting-plan-${env:ENVIRONMENT_SUFFIX}"

    $params = @{
      ResourceType      = 'Appserviceplan'
      ResourceName      = $svcPlanName
      ResourceGroupName = $rgName
    }

    #act
    $servicePlan = Confirm-AzBPResource @params

    #assert
    $servicePlan.Success | Should -BeTrue
  }
}

Describe 'Action Group Tests' {
  it 'Should contain an email action group with the given name' {
    #arrange
    $agName = "benchpress-email-action-group-${env:ENVIRONMENT_SUFFIX}"
    $params = @{
      ResourceType      = 'ActionGroup'
      ResourceName      = $agName
      ResourceGroupName = $rgName
    }


    #act
    $ag = Confirm-AzBPResource @params

    #assert
    $ag.Success | Should -BeTrue
  }
}

Describe 'Web Apps Tests' {
  it 'Should contain a web app with the given name' {
    #arrange
    $params = @{
      ResourceType      = 'WebApp'
      ResourceName      = $webAppName
      ResourceGroupName = $rgName
    }

    #act
    $webApp = Confirm-AzBPResource @params

    #assert
    $webApp.Success | Should -BeTrue
  }

  it 'Should have the web app availability state as normal' {
    #arrange
    $params = @{
      ResourceType      = 'WebApp'
      ResourceName      = $webAppName
      ResourceGroupName = $rgName
      PropertyKey       = 'AvailabilityState'
      PropertyValue     = 'Normal'
    }

    #act
    $webApp = Confirm-AzBPResource @params

    #assert
    $webApp.Success | Should -BeTrue
  }

  it 'Should have the web app works https only' {
    $params = @{
      ResourceType      = 'WebApp'
      ResourceName      = $webAppName
      ResourceGroupName = $rgName
      PropertyKey       = 'HttpsOnly'
      PropertyValue     = $true
    }

    #act
    $webApp = Confirm-AzBPResource @params

    #assert
    $webApp.Success | Should -BeTrue
  }

  it 'Should contain configuration in the web app' {
    $params = @{
      ResourceType      = 'WebApp'
      ResourceName      = $webAppName
      ResourceGroupName = $rgName
      PropertyKey       = 'SiteConfig'
      PropertyValue     = $true
    }

    #act
    $webApp = Confirm-AzBPResource @params

    #assert
    $webApp.Success | Should -BeTrue
  }

  it 'Should contain application insights configuration in the web app' {
    #arrange

    <#
    #act
    $webApp = Get-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webAppName
    $aiAppSetting = $webApp.SiteConfig.AppSettings | Where-object {$_.Name -eq "APPLICATIONINSIGHTS_CONNECTION_STRING"} | Select-Object -First 1

    #assert
    $aiAppSetting | Should -Not -BeNullOrEmpty
    #>
  }
}

AfterAll {
  Get-Module Az-InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
