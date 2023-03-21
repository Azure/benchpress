BeforeAll {
  Import-Module Az.InfrastructureTesting

  $rgName = 'rg-test'
  $webappName = 'azbpwebapptest'
  $location = 'westus3'
}

Describe 'Verify Web App Exists' {
  It 'Should contain a Web App with the given name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType = "WebApp"
      ResourceGroupName = $rgName
      ResourceName = $webappName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain a Web App named $webappName - ConfirmAzBPResource" {
    #arrange
    $params = @{
      ResourceType = "WebApp"
      ResourceGroupName = $rgName
      ResourceName = $webappName
      PropertyKey = 'Name'
      PropertyValue = $webappName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should contain a Web App with the given name' {
    #act
    $result = Confirm-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webappName

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should not contain a Web App with the given name' {
    #arrange
    $webappName = 'noazbpwebapptest'

    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webappName -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }

  It "Should contain a Web App named $webappName" {
    #act
    $result = Confirm-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webappName

    #assert
    $result | Should -BeDeployed
  }

  It "Should contain a Web App named $webappName in $location" {
    #act
    $result = Confirm-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webappName

    #assert
    $result | Should -BeInLocation $location
  }

  It "Should be a Web App in a resource group named $rgName" {
    #act
    $result = Confirm-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webappName

    #assert
    $result | Should -BeInResourceGroup $rgName
  }
}
