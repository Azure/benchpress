BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:appInsightsName = 'appinsightstest'
  $Script:noAppInsightsName = 'noappinsights'
  $Script:location = 'westus3'
}

Describe 'Verify Application Insights' {
  It "Should contain an Application Insights named $appInsightsName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "AppInsights"
      ResourceName      = $appInsightsName
      ResourceGroupName = $rgName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an Application Insights named $appInsightsName with Application Type of web -
  Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "AppInsights"
      ResourceName      = $appInsightsName
      ResourceGroupName = $rgName
      PropertyKey       = "ApplicationType"
      PropertyValue     = "web"
    }

    # act and assert
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

Describe 'Verify Diagnostic Setting' {
  BeforeAll {
    $Script:diagnosticSettingName = 'diagnosticsettingtest'
    $Script:resourceId = "path/for/resourceId"
    $Script:noDiagnosticSettingName = 'nodiagnosticsettingtest'
  }

  It "Should contain a Diagnostic Setting named $diagnosticSettingName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "DiagnosticSetting"
      ResourceName      = $diagnosticSettingName
      ResourceId        = $resourceId
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Diagnostic Setting named $diagnosticSettingName with Type of aksCluster -
  Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "DiagnosticSetting"
      ResourceName      = $diagnosticSettingName
      ResourceId        = $resourceId
      PropertyKey       = "Type"
      PropertyValue     = "Microsoft.Insights/diagnosticSettings"
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Diagnostic Setting named $diagnosticSettingName" {
    Confirm-AzBPDiagnosticSetting -ResourceId $ResourceId -Name $diagnosticSettingName | Should -BeSuccessful
  }

  It "Should contain a Diagnostic Setting named $diagnosticSettingName in $rgName" {
    Confirm-AzBPDiagnosticSetting -ResourceId $ResourceId -Name $diagnosticSettingName | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
