BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:acrName = 'acrbenchpresstest'
  $Script:location = 'westus3'
}

Describe 'Verify Container Registry' {
  BeforeAll {
    $Script:noContainerRegistryName = 'nocontainerregistry'
  }

  It "Should contain a container registry named $acrName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "ContainerRegistry"
      ResourceName      = $acrName
      ResourceGroupName = $rgName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a container registry named $acrName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "ContainerRegistry"
      ResourceName      = $acrName
      ResourceGroupName = $rgName
      PropertyKey       = "SkuName"
      PropertyValue     = "Standard"
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Container Registry named $acrName" {
    Confirm-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName | Should -BeSuccessful
  }

  It 'Should not contain a container registry with the given name' {
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName     = $rgName
      Name                  = $noContainerRegistryName
      ErrorAction           = "SilentlyContinue"
    }
    Confirm-AzBPContainerRegistry @params | Should -Not -BeSuccessful
  }

  It "Should contain a Container Registry named $acrName in $location" {
    Confirm-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName | Should -BeInLocation $location
  }

  It "Should contain a Container Registry named $acrName in a resource group named $rgName" {
    Confirm-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
