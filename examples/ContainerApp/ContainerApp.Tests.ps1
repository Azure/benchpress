BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName   = 'rg-test'
  $Script:location = 'westus3'
}

Describe 'Verify Container Application' {
  BeforeAll {
    $Script:containerAppName   = 'containerAppBenchPressTest'
    $Script:noContainerAppName = 'nocontainerapp'
  }

  It "Should contain a Container Application named $containerAppName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "ContainerApp"
      ResourceName      = $containerAppName
      ResourceGroupName = $rgName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Container Application with an Ingress Port of 80 - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "ContainerApp"
      ResourceName      = $containerAppName
      ResourceGroupName = $rgName
      PropertyKey       = "IngressTargetPort"
      PropertyValue     = 80
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Container Application named $containerAppName" {
    Confirm-AzBPContainerApp -ResourceGroupName $rgName -Name $containerAppName | Should -BeSuccessful
  }

  It "Should not contain a Container Application named $noContainerAppName" {
    # arrange
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      Name              = $noContainerAppName
      ErrorAction       = 'SilentlyContinue'
    }

    # act and assert
    Confirm-AzBPContainerApp @params | Should -Not -BeSuccessful
  }

  It "Should contain a Container Application named $containerAppName in $location" {
    Confirm-AzBPContainerApp -ResourceGroupName $rgName -Name $containerAppName | Should -BeInLocation $location
  }

  It "Should contain a Container Application named $containerAppName in $rgName" {
    Confirm-AzBPContainerApp -ResourceGroupName $rgName -Name $containerAppName | Should -BeInResourceGroup $rgName
  }
}

Describe 'Verify Container Application Managed Environment' {
  BeforeAll {
    $Script:managedEnvName   = 'managedenvbenchpresstest'
    $Script:noManagedEnvName = 'nomanagedenv'
  }

  It "Should contain a Container Application Managed Environment named $managedEnvName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "ContainerAppManagedEnv"
      ResourceName      = $managedEnvName
      ResourceGroupName = $rgName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Container Application Managed Environment named $managedEnvName -
    Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "ContainerAppManagedEnv"
      ResourceName      = $managedEnvName
      ResourceGroupName = $rgName
      PropertyKey       = "Name"
      PropertyValue     = $managedEnvName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Container Application named $managedEnvName" {
    Confirm-AzBPContainerAppManagedEnv -ResourceGroupName $rgName -Name $managedEnvName | Should -BeSuccessful
  }

  It "Should contain a Container Application named $managedEnvName in $location" {
    Confirm-AzBPContainerAppManagedEnv -ResourceGroupName $rgName -Name $managedEnvName
    | Should -BeInLocation $location
  }

  It "Should contain a Container Application named $managedEnvName in $rgName" {
    Confirm-AzBPContainerAppManagedEnv -ResourceGroupName $rgName -Name $managedEnvName
    | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
