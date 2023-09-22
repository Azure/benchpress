BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:noRgName = 'notestrg'
  $Script:location = 'westus3'
}

Describe 'Verify Resource Group Exists' {
  It "Should contain a Resource Group named $rgName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "ResourceGroup"
      ResourceName      = $rgName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }


  It "Should contain a Resource Group named $rgName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "ResourceGroup"
      ResourceName      = $rgName
      PropertyKey       = 'ResourceGroupName'
      PropertyValue     = $rgName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Resource Group named $rgName" {
    Confirm-AzBPResourceGroup -ResourceGroupName $rgName | Should -BeSuccessful
  }

  It "Should not contain a Resource Group named $noRgName" {
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    Confirm-AzBPResourceGroup -ResourceGroupName $noRgName -ErrorAction SilentlyContinue | Should -Not -BeSuccessful
  }

  It "Should contain a Resource Group named $rgName in $location" {
    Confirm-AzBPResourceGroup -ResourceGroupName $rgName | Should -BeInLocation $location
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
