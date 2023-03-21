BeforeAll {
  Import-Module Az.InfrastructureTesting
}

$resourceType = "AppInsights"
$appInsightsName = "aksbenchpresstest"
$rgName = "rg-test"

Describe 'Verify App Insights with Confirm-AzBPResource' {
  it 'Should contain an App Insights named aksbenchpresstest' {
    #arrange
    $params = @{
      ResourceType      = $resourceType
      ResourceName      = $appInsightsName
      ResourceGroupName = $rgName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  it 'Should contain an App Insights named aksbenchpresstest with application type of web' {
    #arrange
    $params = @{
      ResourceType      = $resourceType
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
}

Describe 'Verify App Insights' {
  it 'Should contain an application insights with the given name' {
    #act
    $result = Confirm-AzBPAppInsights -ResourceGroupName $rgName -Name $appInsightsName

    #assert
    $result.Success | Should -Be $true
  }
}

Describe 'Verify App Insights Does Not Exist' {
  it 'Should not contain an application insights with the given name' {
    #arrange
    $appInsightsName = "noappinsightstest"

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPAppInsights -ResourceGroupName $rgName -Name $appInsightsName -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }
}

Describe 'Verify App Insights Exists with Custom Assertion' {
  it 'Should contain an App Insights named appinsightstest' {
    #act
    $result = Confirm-AzBPAppInsights -ResourceGroupName $rgName -Name $appInsightsName

    #assert
    $result | Should -BeDeployed
  }
}

Describe 'Verify App Insights Exists in Correct Location' {
  it 'Should contain an App Insights named appinsightstest in westus3' {
    #act
    $result = Confirm-AzBPAppInsights -ResourceGroupName $rgName -Name $appInsightsName

    #assert
    $result | Should -BeInLocation 'westus3'
  }
}

Describe 'Verify App Insights Exists in Resource Group' {
  it 'Should be in a resource group named rg-test' {
    #act
    $result = Confirm-AzBPAppInsights -ResourceGroupName $rgName -Name $appInsightsName

    #assert
    $result | Should -BeInResourceGroup $rgName
  }
}
