BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:webappName = 'azbpwebapptest'
  $Script:noWebAppName = 'noazbpwebapptest'
  $Script:location = 'westus3'
}

Describe 'Verify Web App Exists' {
  It "Should contain a Web App named $webappName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "WebApp"
      ResourceGroupName = $rgName
      ResourceName      = $webappName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Web App named $webappName - ConfirmAzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "WebApp"
      ResourceGroupName = $rgName
      ResourceName      = $webappName
      PropertyKey       = 'Name'
      PropertyValue     = $webappName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Web App named $webappName" {
    Confirm-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webappName | Should -BeSuccessful
  }

  It "Should not contain a Web App named $noWebappName" {
    #arrange
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    Confirm-AzBPWebApp -ResourceGroupName $rgName -WebAppName $noWebappName -ErrorAction SilentlyContinue
    | Should -Not -BeSuccessful
  }

  It "Should contain a Web App named $webappName in $location" {
    Confirm-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webappName | Should -BeInLocation $location
  }

  It "Should contain a Web App named $webappName in $rgName" {
    Confirm-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webappName | Should -BeInResourceGroup $rgName
  }
}

Describe 'Verify Web App Config'{
  BeforeAll{
    $Script:appInsightsSettingName = 'APPLICATIONINSIGHTS_CONNECTION_STRING'
  }

  It "Should contain an App Setting named $appInsightsSettingName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "WebApp"
      ResourceGroupName = $rgName
      ResourceName      = $webappName
      PropertyKey       = 'SiteConfig.AppSettings[1].Name'
      PropertyValue     = $appInsightsSettingName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }
}

Describe 'Verify Web App Static Site Exists' {
  BeforeAll {
    $Script:webappStaticSiteName = 'staticwebapptest'
    $Script:noWebAppStaticSiteName = 'nostaticwebapptest'
  }

  It "Should contain a Web App named $webappStaticSiteName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "WebAppStaticSite"
      ResourceGroupName = $rgName
      ResourceName      = $webappStaticSiteName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Web App named $webappStaticSiteName - ConfirmAzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "WebAppStaticSite"
      ResourceGroupName = $rgName
      ResourceName      = $webappStaticSiteName
      PropertyKey       = 'Name'
      PropertyValue     = $webappStaticSiteName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Web App named $webappStaticSiteName" {
    Confirm-AzBPWebAppStaticSite -ResourceGroupName $rgName -StaticWebAppName $webappStaticSiteName
    | Should -BeSuccessful
  }

  It "Should not contain a Web App named $nowebappStaticSiteName" {
    # arrange
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      StaticWebAppName  = $nowebappstaticsitename
      ErrorAction       = "SilentlyContinue"
    }

    # act and assert
    Confirm-AzBPWebAppStaticSite @params | Should -Not -BeSuccessful
  }

  It "Should contain a Web App named $webappStaticSiteName in $location" {
    Confirm-AzBPWebAppStaticSite -ResourceGroupName $rgName -StaticWebAppName $webappStaticSiteName
    | Should -BeInLocation $location
  }

  It "Should contain a Web App named $webappStaticSiteName in $rgName" {
    Confirm-AzBPWebAppStaticSite -ResourceGroupName $rgName -StaticWebAppName $webappStaticSiteName
    | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
