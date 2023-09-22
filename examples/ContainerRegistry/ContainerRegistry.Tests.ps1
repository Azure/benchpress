BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName                  = 'rg-test'
  $Script:acrName                 = 'acrbenchpresstest'
  $Script:location                = 'westus3'
  $Script:noContainerRegistryName = 'nocontainerregistry'
}

Describe 'Verify Container Registry' {
  It "Should contain a Container Registry named $acrName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "ContainerRegistry"
      ResourceName      = $acrName
      ResourceGroupName = $rgName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Container Registry named $acrName with a Standard SKU - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "ContainerRegistry"
      ResourceName      = $acrName
      ResourceGroupName = $rgName
      PropertyKey       = "SkuName"
      PropertyValue     = "Basic"
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Container Registry named $acrName" {
    Confirm-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName | Should -BeSuccessful
  }

  It "Should not contain a Container Registry named $noContainerRegistryName" {
    # arrange
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName     = $rgName
      Name                  = $noContainerRegistryName
      ErrorAction           = "SilentlyContinue"
    }

    # act and assert
    Confirm-AzBPContainerRegistry @params | Should -Not -BeSuccessful
  }

  It "Should contain a Container Registry named $acrName in $location" {
    Confirm-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName | Should -BeInLocation $location
  }

  It "Should contain a Container Registry named $acrName in $rgName" {
    Confirm-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
