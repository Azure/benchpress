BeforeAll {
  # Navigate to ../../docs/installation.md to build BenchPress module"

  #Import-Module "../../bin/BenchPress.Azure.psd1"

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
    Confirm-AzBPResource @params | Should -BeDeployed
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
    Confirm-AzBPResource @params | Should -BeDeployed
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
    Confirm-AzBPResource @params | Should -BeDeployed
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
    Confirm-AzBPResource @params | Should -BeDeployed
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
    Confirm-AzBPResource @params | Should -BeDeployed
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
    Confirm-AzBPResource @params | Should -BeDeployed
  }

  it 'Should contain application insights configuration in the web app' {
    #arrange
    $params = @{
      ResourceType      = 'WebApp'
      ResourceName      = $webAppName
      ResourceGroupName = $rgName
      PropertyKey       = 'SiteConfig.AppSettings[1].Name'
      PropertyValue     = 'APPLICATIONINSIGHTS_CONNECTION_STRING'
    }

    #act
    Confirm-AzBPResource @params | Should -BeDeployed
  }
}

AfterAll {
  Get-Module Az-InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
