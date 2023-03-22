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

  it 'Should contain an App Service Plan - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType      = "Appserviceplan"
      ResourceName      = $appServicePlanName
      ResourceGroupName = $rgName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain an App Service Plan - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType      = "Appserviceplan"
      ResourceName      = $appServicePlanName
      ResourceGroupName = $rgName
      PropertyKey       = "Sku.Tier"
      PropertyValue     = "Free"
    }
    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain an App Service Plan with the given name' {
    #act
    $result = Confirm-AzBPAppServicePlan -ResourceGroupName $rgName -AppServicePlanName $appServicePlanName

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should not contain an App Service Plan with the given name' {
    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPAppServicePlan -ResourceGroupName $rgName -AppServicePlanName $noAppServicePlanName -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }

  it "Should contain an App Service Plan named $appServicePlanName" {
    #act
    $result = Confirm-AzBPAppServicePlan -ResourceGroupName $rgName -AppServicePlanName $appServicePlanName

    #assert
    $result | Should -BeDeployed
  }

  it "Should contain an App Service Plan named $appServicePlanName in $location" {
    #act
    $result = Confirm-AzBPAppServicePlan -ResourceGroupName $rgName -AppServicePlanName $appServicePlanName

    #assert
    $result | Should -BeInLocation $location
  }

  it "Should contain an App Service Plan named $appServicePlanName in a resource group named $rgName" {
    #act
    $result = Confirm-AzBPAppServicePlan -ResourceGroupName $rgName -AppServicePlanName $appServicePlanName

    #assert
    $result | Should -BeInResourceGroup $rgName
  }
}
