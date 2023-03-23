BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:appInsightsName = 'appinsightstest'
  $Script:location = 'westus3'
}

Describe 'Verify App Insights' {
  BeforeAll {
    $Script:noAppInsightsName = 'noappinsights'
  }

  It "Should contain an App Insights named $appInsightsName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "AppInsights"
      ResourceName      = $appInsightsName
      ResourceGroupName = $rgName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain an App Insights named $appInsightsName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "AppInsights"
      ResourceName      = $appInsightsName
      ResourceGroupName = $rgName
      PropertyKey       = "ApplicationType"
      PropertyValue     = "web"
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should contain an application insights with the given name' {
    #act
    $result = Confirm-AzBPAppInsights -ResourceGroupName $rgName -Name $appInsightsName

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should not contain an application insights with the given name' {
    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPAppInsights -ResourceGroupName $rgName -Name $noAppInsightsName -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }

  It "Should contain an App Insights named $appInsightsName" {
    #act
    $result = Confirm-AzBPAppInsights -ResourceGroupName $rgName -Name $appInsightsName

    #assert
    $result | Should -BeDeployed
  }

  It "Should contain an App Insights named $appInsightsName in $location" {
    #act
    $result = Confirm-AzBPAppInsights -ResourceGroupName $rgName -Name $appInsightsName

    #assert
    $result | Should -BeInLocation $location
  }

  It "Should contain an App Insights named $appInsightsName in a resource group named $rgName" {
    #act
    $result = Confirm-AzBPAppInsights -ResourceGroupName $rgName -Name $appInsightsName

    #assert
    $result | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az-InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
