BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:appServicePlanName = 'appserviceplantest'
  $Script:location = 'westus3'
}

Describe 'Verify App Service Plan' {
  BeforeAll {
    $Script:noAppServicePlanName = 'noappservicetestbp'
  }

  It "Should contain an App Service Plan named $appServicePlanName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "Appserviceplan"
      ResourceName      = $appServicePlanName
      ResourceGroupName = $rgName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an App Service Plan named $appServicePlanName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "Appserviceplan"
      ResourceName      = $appServicePlanName
      ResourceGroupName = $rgName
      PropertyKey       = "Sku.Tier"
      PropertyValue     = "Free"
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an App Service Plan named $appServicePlanName" {
    Confirm-AzBPAppServicePlan -ResourceGroupName $rgName -AppServicePlanName $appServicePlanName
    | Should -BeSuccessful
  }

  It 'Should not contain an App Service Plan with the given name' {
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName     = $rgName
      AppServicePlanName    = $noAppServicePlanName
      ErrorAction           = "SilentlyContinue"
    }
    Confirm-AzBPAppServicePlan @params | Should -Not -BeSuccessful
  }

  It "Should contain an App Service Plan named $appServicePlanName in $location" {
    Confirm-AzBPAppServicePlan -ResourceGroupName $rgName -AppServicePlanName $appServicePlanName
    | Should -BeInLocation $location
  }

  It "Should contain an App Service Plan named $appServicePlanName in a resource group named $rgName" {
    Confirm-AzBPAppServicePlan -ResourceGroupName $rgName -AppServicePlanName $appServicePlanName
    | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
