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

  It "Should contain a Container Application named $conAppName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "ContainerApp"
      ResourceName      = $conAppName
      ResourceGroupName = $rgName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Container Application with an Ingress Port of 80 - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "ContainerApp"
      ResourceName      = $conAppName
      ResourceGroupName = $rgName
      PropertyKey       = "IngressTargetPort"
      PropertyValue     = 80
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain a Container Application named $conAppName" {
    Confirm-AzBPContainerApp -ResourceGroupName $rgName -Name $conAppName | Should -BeSuccessful
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

  It "Should contain a Container Application named $conAppName in $location" {
    Confirm-AzBPContainerApp -ResourceGroupName $rgName -Name $conAppName | Should -BeInLocation $location
  }

  It "Should contain a Container Application named $conAppName in $rgName" {
    Confirm-AzBPContainerApp -ResourceGroupName $rgName -Name $conAppName | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
