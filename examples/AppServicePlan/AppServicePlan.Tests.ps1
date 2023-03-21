BeforeAll {
  Import-Module Az.InfrastructureTesting
}

$resourceType = "Appserviceplan"
$appServicePlanName = "appserviceplantest"
$rgName = "rg-test"

Describe 'Verify App Service Plan with Confirm-AzBPResource' {
  it 'Should contain an App Service Plan named appserviceplantest' {
    #arrange
    $params = @{
      ResourceType      = $resourceType
      ResourceName      = $appServicePlanName
      ResourceGroupName = $rgName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain an App Service Plan named appserviceplantest with sku tier of Free' {
    #arrange
    $params = @{
      ResourceType      = $resourceType
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
}

Describe 'Verify App Service Plan Exists' {
  it 'Should contain an App Service Plan with the given name' {
      #act
      $result = Confirm-AzBPAppServicePlan -ResourceGroupName $rgName -AppServicePlanName $appServicePlanName

      #assert
      $result.Success | Should -Be $true
  }
}

Describe 'Verify App Service Plan Does Not Exist' {
  it 'Should not contain an App Service Plan with the given name' {
      #arrange
      $appServicePlanName = 'noappserviceplantest'

      #act
      # The '-ErrorAction SilentlyContinue' command suppresses all errors.
      # In this test, it will suppress the error message when a resource cannot be found.
      # Remove this field to see all errors.
      $result = Confirm-AzBPAppServicePlan -ResourceGroupName $rgName -AppServicePlanName $appServicePlanName -ErrorAction SilentlyContinue

      #assert
      $result.Success | Should -Be $false
  }
}

Describe 'Verify App Service Plan Exists with Custom Assertion' {
  it 'Should contain an App Service Plan named appserviceplantest' {
    #act
    $result = Confirm-AzBPAppServicePlan -ResourceGroupName $rgName -AppServicePlanName $appServicePlanName

    #assert
    $result | Should -BeDeployed
  }
}

Describe 'Verify App Service Plan Exists in Correct Location' {
  it 'Should contain an App Service Plan named appserviceplantest in westus3' {
    #act
    $result = Confirm-AzBPAppServicePlan -ResourceGroupName $rgName -AppServicePlanName $appServicePlanName

    #assert
    $result | Should -BeInLocation 'westus3'
  }
}

Describe 'Verify App Service Plan Exists in Resource Group' {
  it 'Should be in a resource group named rg-test' {
    #act
    $result = Confirm-AzBPAppServicePlan -ResourceGroupName $rgName -AppServicePlanName $appServicePlanName

    #assert
    $result | Should -BeInResourceGroup $rgName
  }
}
