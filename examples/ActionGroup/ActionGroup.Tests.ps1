BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:actionGroupName = 'sampleaction'
  $Script:location = 'global'
  $Script:noActionGroupName = "noactiongroup"
}

Describe 'Verify Action Group' {
  It "Should contain an Action Group named $actionGroupName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = 'ActionGroup'
      ResourceName      = $actionGroupName
      ResourceGroupName = $rgName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an Action Group named $actionGroupName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = 'ActionGroup'
      ResourceName      = $actionGroupName
      ResourceGroupName = $rgName
      PropertyKey       = "GroupShortName"
      PropertyValue     = $actionGroupName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an Action Group named $actionGroupName" {
    Confirm-AzBPActionGroup -ResourceGroupName $rgName -ActionGroupName $actionGroupName | Should -BeSuccessful
  }

  It "Should not contain an Action Group named $noActionGroupName" {
    # arrange
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      ActionGroupName   = $noActionGroupName
      ErrorAction       = "SilentlyContinue"
    }
    # act and assert
    Confirm-AzBPActionGroup @params | Should -Not -BeSuccessful
  }

  It "Should contain an Action Group named $actionGroupName in $location" {
    Confirm-AzBPActionGroup -ResourceGroupName $rgName -ActionGroupName $actionGroupName
    | Should -BeInLocation $location
  }

  It "Should contain an Action Group named $actionGroupName in $rgName" {
    Confirm-AzBPActionGroup -ResourceGroupName $rgName -ActionGroupName $actionGroupName
    | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
