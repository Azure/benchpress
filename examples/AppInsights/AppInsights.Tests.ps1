BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:appInsightsName = 'appinsightstest'
  $Script:location = 'westus3'
}

Describe 'Verify Application Insights' {
  BeforeAll {
    $Script:noAppInsightsName = 'noappinsights'
  }

  It "Should contain an Application Insights named $appInsightsName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "AppInsights"
      ResourceName      = $appInsightsName
      ResourceGroupName = $rgName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an Application Insights named $appInsightsName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "AppInsights"
      ResourceName      = $appInsightsName
      ResourceGroupName = $rgName
      PropertyKey       = "ApplicationType"
      PropertyValue     = "web"
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an Application Insights named $appInsightsName" {
    Confirm-AzBPAppInsights -ResourceGroupName $rgName -Name $appInsightsName | Should -BeSuccessful
  }

  It "Should not contain an Application Insights named $noAppInsightsName" {
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    Confirm-AzBPAppInsights -ResourceGroupName $rgName -Name $noAppInsightsName -ErrorAction SilentlyContinue
    | Should -Not -BeSuccessful
  }

  It "Should contain an Application Insights named $appInsightsName in $location" {
    Confirm-AzBPAppInsights -ResourceGroupName $rgName -Name $appInsightsName | Should -BeInLocation $location
  }

  It "Should contain an Application Insights named $appInsightsName in $rgName" {
    Confirm-AzBPAppInsights -ResourceGroupName $rgName -Name $appInsightsName | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
