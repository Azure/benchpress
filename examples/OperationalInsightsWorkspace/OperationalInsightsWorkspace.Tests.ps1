BeforeAll {
  Import-Module Az.InfrastructureTesting

  $Script:rgName = 'rg-test'
  $Script:oiwName = 'oiwName'
  $Script:noOiwName = 'noOiwName'
  $Script:location = 'westus3'
}

Describe 'Verify Operational Insights Workspace Exists' {
  It "Should contain an Operational Insights Workspace named $oiwName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "OperationalInsightsWorkspace"
      ResourceGroupName = $rgName
      ResourceName      = $oiwName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }


  It "Should contain an Operational Insights Workspace named $oiwName - Confirm-AzBPResource" {
    # arrange
    $params = @{
      ResourceType      = "OperationalInsightsWorkspace"
      ResourceGroupName = $rgName
      ResourceName      = $oiwName
      PropertyKey       = 'Name'
      PropertyValue     = $oiwName
    }

    # act and assert
    Confirm-AzBPResource @params | Should -BeSuccessful
  }

  It "Should contain an Operational Insights Workspace named $oiwName" {
    Confirm-AzBPOperationalInsightsWorkspace -ResourceGroupName $rgName -Name $oiwName | Should -BeSuccessful
  }

  It "Should not contain an Operational Insights Workspace named $noOiwName" {
    # arrange
    # The '-ErrorAction SilentlyContinue' command suppresses all errors.
    # In this test, it will suppress the error message when a resource cannot be found.
    # Remove this field to see all errors.
    $params = @{
      ResourceGroupName = $rgName
      Name              = $noOiwName
      ErrorAction       = "SilentlyContinue"
    }

    # act and asssert
    Confirm-AzBPOperationalInsightsWorkspace @params | Should -Not -BeSuccessful
  }

  It "Should contain an Operational Insights Workspace named $oiwName in $location" {
    Confirm-AzBPOperationalInsightsWorkspace -ResourceGroupName $rgName -Name $oiwName | Should -BeInLocation $location
  }

  It "Should contain an Operational Insights Workspace named $oiwName in $rgName" {
    Confirm-AzBPOperationalInsightsWorkspace -ResourceGroupName $rgName -Name $oiwName
    | Should -BeInResourceGroup $rgName
  }
}

AfterAll {
  Get-Module Az.InfrastructureTesting | Remove-Module
  Get-Module BenchPress.Azure | Remove-Module
}
