BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:conAppName = 'conAppBenchPressTest'
  $Script:location = 'westus3'
}

Describe 'Verify Container Application' {
  BeforeAll {
    $Script:noContainerAppName = 'nocontainerapp'
  }

  It "Should contain a container application named $conAppName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "ContainerApp"
      ResourceName      = $conAppName
      ResourceGroupName = $rgName
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It "Should contain a container application with an ingress target port of 80 - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = "ContainerApp"
      ResourceName      = $conAppName
      ResourceGroupName = $rgName
      PropertyKey       = "IngressTargetPort"
      PropertyValue     = 80
    }

    #act
    $result = Confirm-AzBPResource @params

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should contain a container application with the given name' {
    #act
    $result = Confirm-AzBPContainerApp -ResourceGroupName $rgName -Name $conAppName

    #assert
    $result.Success | Should -Be $true
  }

  It 'Should not contain a container application with the given name' {
    #act
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $result = Confirm-AzBPContainerApp -ResourceGroupName $rgName -Name $noContainerAppName -ErrorAction SilentlyContinue

    #assert
    $result.Success | Should -Be $false
  }

  It "Should contain a Container application named $conAppName" {
    #act
    $result = Confirm-AzBPContainerApp -ResourceGroupName $rgName -Name $conAppName

    #assert
    $result | Should -BeDeployed
  }

  It "Should contain a Container application named $conAppName in $location" {
    #act
    $result = Confirm-AzBPContainerApp -ResourceGroupName $rgName -Name $conAppName

    #assert
    $result | Should -BeInLocation $location
  }

  It "Should contain a Container application named $conAppName in a resource group named $rgName" {
    #act
    $result = Confirm-AzBPContainerApp -ResourceGroupName $rgName -Name $conAppName

    #assert
    $result | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az-InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
