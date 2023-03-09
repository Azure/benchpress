BeforeAll {
  Import-Module Az-InfrastructureTest
}

Describe 'Verify Web App Exists' {
  it 'Should contain a Web App with the given name' {
    #arrange
    $rgName = 'rg-test'
    $webappName = 'azbpwebapptest'

    #act
    $result = Confirm-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webappName

    #assert
    $result.Success | Should -Be $true
  }
}

Describe 'Verify Web App Does Not Exist' {
  it 'Should not contain a Web App with the given name' {
    #arrange
    $rgName = 'rg-test'
    $webappName = 'noazbpwebapptest'

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webappName -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }
}

Describe 'Verify Web App Exists with Custom Assertion' {
  it 'Should contain a Web App named azbpwebapptest' {
    #arrange
    $rgName = 'rg-test'
    $webappName = 'azbpwebapptest'

    #act
    $result = Confirm-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webappName

    #assert
    $result | Should -BeDeployed
  }
}

Describe 'Verify Web App Exists in Correct Location' {
  it 'Should contain a Web App named azbpwebapptest in westus3' {
    #arrange
    $rgName = 'rg-test'
    $webappName = 'azbpwebapptest'

    #act
    $result = Confirm-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webappName

    #assert
    $result | Should -BeInLocation 'westus3'
  }
}

Describe 'Verify Web App Exists in Resource Group' {
  it 'Should be a Web App in a resource group named rg-test' {
    #arrange
    $rgName = 'rg-test'
    $webappName = 'azbpwebapptest'

    #act
    $result = Confirm-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webappName

    #assert
    $result | Should -BeInResourceGroup 'rg-test'
  }
}
