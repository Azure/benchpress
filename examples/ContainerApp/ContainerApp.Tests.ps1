BeforeAll {
  Import-Module ../../bin/BenchPress.Azure.psd1

  $Script:rgName = 'marysha-devwork'
  $Script:location = 'westus3'
}

Describe 'Verify Container Application' {
  BeforeAll {
    $Script:conAppName = 'acrklhab' #'conAppBenchPressTest'
    $Script:noContainerAppName = 'nocontainerapp'
  }

  It "Should contain a Container Application named $conAppName - Confirm-AzBPResource" {
    $params = @{
      ResourceType      = "ContainerApp"
      ResourceName      = $conAppName
      ResourceGroupName = $rgName
    }

    (Confirm-AzBPResource @params).Success | Should -Be $true
  }

  It "Should contain a Container Application with an Ingress Port of 80 - Confirm-AzBPResource" {
    $params = @{
      ResourceType      = "ContainerApp"
      ResourceName      = $conAppName
      ResourceGroupName = $rgName
      PropertyKey       = "IngressTargetPort"
      PropertyValue     = 80
    }

    (Confirm-AzBPResource @params).Success | Should -Be $true
  }

  It "Should contain a Container Application named $conAppName" {
    (Confirm-AzBPContainerApp -ResourceGroupName $rgName -Name $conAppName).Success | Should -Be $true
  }

  It "Should not contain a Container Application named $noContainerAppName" {
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      Name              = $noContainerAppName
      ErrorAction       = 'SilentlyContinue'
    }

    (Confirm-AzBPContainerApp @params).Success | Should -Be $false
  }

  It "Should contain a Container Application named $conAppName" {
    Confirm-AzBPContainerApp -ResourceGroupName $rgName -Name $conAppName | Should -BeDeployed
  }

  It "Should contain a Container Application named $conAppName in $location" {
    Confirm-AzBPContainerApp -ResourceGroupName $rgName -Name $conAppName | Should -BeInLocation $location
  }

  It "Should contain a Container Application named $conAppName in $rgName" {
    Confirm-AzBPContainerApp -ResourceGroupName $rgName -Name $conAppName | Should -BeInResourceGroup $rgName
  }
}

Describe 'Verify Container Application Managed Environment' {
  BeforeAll {
    $Script:managedEnvName = 'envacrklhab'
    $Script:noManagedEnvName = 'nomanagedenv'
  }

  It "Should contain a Container Application Managed Environment named $managedEnvName - Confirm-AzBPResource" {
    $params = @{
      ResourceType      = "ContainerAppManagedEnv"
      ResourceName      = $managedEnvName
      ResourceGroupName = $rgName
    }

    (Confirm-AzBPResource @params).Success | Should -Be $true
  }

  It "Should contain a Container Application Managed Environment with a name of $managedEnvName -
    Confirm-AzBPResource" {
    $params = @{
      ResourceType      = "ContainerAppManagedEnv"
      ResourceName      = $managedEnvName
      ResourceGroupName = $rgName
      PropertyKey       = "Name"
      PropertyValue     = $managedEnvName
    }

    (Confirm-AzBPResource @params).Success | Should -Be $true
  }

  It "Should contain a Container Application named $managedEnvName" {
    (Confirm-AzBPContainerAppManagedEnv -ResourceGroupName $rgName -Name $managedEnvName).Success | Should -Be $true
  }

  It "Should contain a Container Application named $managedEnvName" {
    Confirm-AzBPContainerAppManagedEnv -ResourceGroupName $rgName -Name $managedEnvName | Should -BeDeployed
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
