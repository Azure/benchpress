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

  It "Should contain a Container Registry named $acrName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "ContainerRegistry"
      ResourceName      = $acrName
      ResourceGroupName = $rgName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain a Container Registry named $acrName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "ContainerRegistry"
      ResourceName      = $acrName
      ResourceGroupName = $rgName
      PropertyKey       = "SkuName"
      PropertyValue     = "Standard"
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain a Container Registry named $acrName" {
    #act
    $result = Confirm-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName

    #assert
    $result.Success | Should -Be $true
  }

  It "Should not contain a Container Registry named $noContainerRegistryName" {
    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPContainerRegistry -ResourceGroupName $rgName -Name $noContainerRegistryName -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }

  It "Should contain a Container Registry named $acrName" {
    #act
    $result = Confirm-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName

    #assert
    $result | Should -BeDeployed
  }

  It "Should contain a Container Registry named $acrName in $location" {
    #act
    $result = Confirm-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName

    #assert
    $result | Should -BeInLocation $location
  }

  It "Should contain a Container Registry named $acrName in $rgName" {
    #act
    $result = Confirm-AzBPContainerRegistry -ResourceGroupName $rgName -Name $acrName

    #assert
    $result | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az-InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
