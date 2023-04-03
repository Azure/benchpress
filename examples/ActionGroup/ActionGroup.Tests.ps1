BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:actionGroupName = 'sampleaction'
  $Script:location = 'global'
}

Describe 'Verify Action Group' {
  BeforeAll {
    $Script:noActionGroupName = "noactiongroup"
  }

  It "Should contain an actiongroup named $actionGroupName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = 'ActionGroup'
      ResourceName      = $actionGroupName
      ResourceGroupName = $rgName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an actiongroup named $actionGroupName - Confirm-AzBPResource" {
    #arrange
    $params = @{
      ResourceType      = 'ActionGroup'
      ResourceName      = $actionGroupName
      ResourceGroupName = $rgName
      PropertyKey       = "GroupShortName"
      PropertyValue     = $actionGroupName
    }

    #act
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an action group named $actionGroupName" {
    Confirm-AzBPActionGroup -ResourceGroupName $rgName -ActionGroupName $actionGroupName | Should -BeSuccessful
  }

  It 'Should not contain an action group with given name' {
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      ActionGroupName   = $noActionGroupName
      ErrorAction       = "SilentlyContinue"
    }
    Confirm-AzBPActionGroup @params | Should -Not -BeSuccessful
  }

  It "Should contain an action group named $actionGroupName in $location" {
    Confirm-AzBPActionGroup -ResourceGroupName $rgName -ActionGroupName $actionGroupName
    | Should -BeInLocation $location
  }

  It "Should be an action group named $actionGroupName in a resource group named $rgName" {
    Confirm-AzBPActionGroup -ResourceGroupName $rgName -ActionGroupName $actionGroupName
    | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
