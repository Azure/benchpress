BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:webappName = 'azbpwebapptest'
  $Script:location = 'westus3'
}

Describe 'Verify Web App Exists' {
  BeforeAll {
    $Script:noWebAppName = 'noazbpwebapptest'
  }

  It 'Should contain a Web App with the given name - Confirm-AzBPResource' {
    #arrange
    $params = @{
      ResourceType = "WebApp"
      ResourceGroupName = $rgName
      ResourceName = $webappName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
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

    #act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Web App named $webappName" {
    Confirm-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webappName | Should -BeSuccessful
  }

  It 'Should not contain a Web App with the given name' {
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    Confirm-AzBPWebApp -ResourceGroupName $rgName -WebAppName $noWebappName -ErrorAction SilentlyContinue
    | Should -Not -BeSuccessful
  }

  It "Should contain a Web App named $webappName in $location" {
    Confirm-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webappName | Should -BeInLocation $location
  }

  It "Should be a Web App in a resource group named $rgName" {
    Confirm-AzBPWebApp -ResourceGroupName $rgName -WebAppName $webappName | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
